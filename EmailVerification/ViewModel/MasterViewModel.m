//
//  MasterViewModel.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterViewModel.h"
#import "EmailValidator.h"
#import "NSString+isEmpty__NT.h"
#import "NSString+hasContent__NT.h"
#import <ReactiveObjC/RACEXTScope.h>

@interface MasterViewModel ()

@property (readonly, nonatomic) EmailValidator *validator;

@end

@implementation MasterViewModel

- (void)ensure {
    NSParameterAssert(self.http);

    NSParameterAssert(self.validator);
    
    NSParameterAssert(self.isDeliverable);
    NSParameterAssert(self.isValid);
    NSParameterAssert(self.status);
}

- (instancetype)init {
    return [self initWithHttp:nil];
}

- (instancetype)initWithHttp:(Http *)http {
    NSParameterAssert(http);
    
    self = [super init];
    if (!self) {
        return nil;
    }
    _http = http;
    _validator = [[EmailValidator alloc] init];

    RACSignal *input = RACObserve(self, input);

    RACSignal *isEmpty = [input map:^id (NSString *value) {
        return @(value.isEmpty__NT);
    }];
    
    @weakify(self);
    RACSignal *isValidFormat = [input map:^id (NSString *value) {
        @strongify(self);
        return @([self.validator evaluate:value]);
    }];
    
    _isDeliverable = [[[[[input map:^id(NSString *value) {
        if ([self.validator evaluate:value]) {
            return value;
        }
        return nil;
    }] map:^RACSignal *(NSString *value) {
        @strongify(self);
        if (!value) {
            return [RACSignal return:nil];
        }
        return [[self.http verifyEmail:value] tryMap:^id(id value, NSError **errorPtr) {
            return [[ValidateResponse alloc] initWithAttributes:value];
        }];
    }] switchToLatest] map:^id _Nullable(ValidateResponse *value) {
        if (!value) {
            return nil;
        }
        return @([value.result isEqualToString:@"deliverable"]);
    }] catchTo:[RACSignal empty]];
    
    _isValid = [RACSignal merge:@[self.isDeliverable, isValidFormat]];
    
    _status = [self createStatusWithIsEmpty:isEmpty isValidFormat:isValidFormat isDeliverable:self.isDeliverable];
    
    [self ensure];
    return self;
}

- (RACSignal *)createStatusWithIsEmpty:(RACSignal *)isEmpty isValidFormat:(RACSignal *)isValidFormat isDeliverable:(RACSignal *)isDeliverable {
    RACSignal *emptyStatus = [[isEmpty filter:^BOOL(NSNumber *value) {
        return value.boolValue;
    }] map:^NSString *(id _) {
        return NSLocalizedString(@"Email is empty", @"");
    }];
    
    RACSignal *formatStatus = [isValidFormat map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Email format is correct", @"") : NSLocalizedString(@"Email format is invalid", @"");
    }];
    
    RACSignal *deliverableStatus = [[isDeliverable filter:^BOOL(id value) {
        return value != nil;
    }] map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Looks great!", @"") : NSLocalizedString(@"Undeliverable", @"");
    }];
    
    return [RACSignal merge:@[deliverableStatus, emptyStatus, formatStatus]];
}

@end
