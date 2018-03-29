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

@property (readonly, nonatomic) RACSignal *isEmpty;
@property (readonly, nonatomic) RACSignal *isValidFormat;

@end

@implementation MasterViewModel

- (void)ensure {
    NSParameterAssert(self.http);

    NSParameterAssert(self.validator);
    NSParameterAssert(self.isEmpty);
    NSParameterAssert(self.isValidFormat);
    
    NSParameterAssert(self.errors);
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
    
    _errors = [RACSignal empty];
    
    _isEmpty = [RACObserve(self, input) map:^id (NSString *value) {
        return @(value.isEmpty__NT);
    }];

    @weakify(self);
    _isValidFormat = [RACObserve(self, input) map:^id (NSString *value) {
        @strongify(self);
        return @([self.validator evaluate:value]);
    }];
    
    _deliverable = [[[[[[[RACObserve(self, input) filter:^BOOL(id  _Nullable value) {
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
    }] catchTo:self.errors];
    
    // Is Valid?
    _isValid = [RACSignal merge:@[self.deliverable, self.isValidFormat]];
    
    // Status
    RACSignal *emptyStatus = [[self.isEmpty filter:^BOOL(NSNumber *value) {
        return value.boolValue;
    }] map:^NSString *(id _) {
        return NSLocalizedString(@"Email is empty", @"");
    }];
    RACSignal *formatStatus = [self.isValidFormat map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Email format is correct", @"") : NSLocalizedString(@"Email format is invalid", @"");
    }];
    RACSignal *deliverableStatus = [self.deliverable map:^NSString *(NSNumber *value) {
        return value.boolValue ? NSLocalizedString(@"Email looks great!", @"") : NSLocalizedString(@"Undeliverable", @"");
    }];
    _status = [RACSignal merge:@[emptyStatus, deliverableStatus, formatStatus]];
    
    [self ensure];
    return self;
}

@end
