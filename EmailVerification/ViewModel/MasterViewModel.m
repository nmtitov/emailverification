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
    
    NSParameterAssert(self.deliverable);
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
    
    _deliverable = [[[[[[[input filter:^BOOL(id  _Nullable value) {
        @strongify(self);
        return [self.validator evaluate:value];
    }] throttle:0.3] filter:^BOOL(NSString *value) {
        return value.hasContent__NT;
    }] map:^RACSignal *(id value) {
        @strongify(self);
        return [[self.http verifyEmail:value] tryMap:^id(id value, NSError **errorPtr) {
            return [[ValidateResponse alloc] initWithAttributes:value];
        }];
    }] switchToLatest] map:^id _Nullable(ValidateResponse *value) {
        return @([value.result isEqualToString:@"deliverable"]);
    }] catchTo:[RACSignal empty]];
    
    _isValid = [RACSignal merge:@[self.deliverable, isValidFormat]];
    
    // Status
    RACSignal *emptyStatus = [[isEmpty filter:^BOOL(NSNumber *value) {
        return value.boolValue;
    }] map:^NSString *(id _) {
        return NSLocalizedString(@"Email is empty", @"");
    }];
    RACSignal *formatStatus = [isValidFormat map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Email format is correct", @"") : NSLocalizedString(@"Email format is invalid", @"");
    }];
    RACSignal *deliverableStatus = [self.deliverable map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Success! Email seems to be deliverable!", @"") : NSLocalizedString(@"Undeliverable", @"");
    }];
    _status = [RACSignal merge:@[deliverableStatus, emptyStatus, formatStatus]];
    
    [self ensure];
    return self;
}

@end
