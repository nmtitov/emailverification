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
    
    NSParameterAssert(self.isValid);
    NSParameterAssert(self.status);
    NSParameterAssert(self.deliverable);
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
    
    _isEmpty = [RACObserve(self, input) map:^id (NSString *value) {
        return @(value.isEmpty__NT);
    }];

    @weakify(self);
    _isValidFormat = [RACObserve(self, input) map:^id (NSString *value) {
        @strongify(self);
        return @([self.validator evaluate:value]);
    }];
    
    _isValid = [[RACSignal combineLatest:@[self.isEmpty.not, self.isValidFormat]] map:^(RACTuple *tuple) {
        return @([tuple.rac_sequence all:^(NSNumber *value) {
            return value.boolValue;
        }]);
    }];
    
    _status = [RACSignal combineLatest:@[self.isEmpty, self.isValidFormat] reduce:^NSString *(NSNumber *isEmpty, NSNumber *isValidFormat) {
        if (isEmpty.boolValue) {
            return NSLocalizedString(@"Email is empty", @"");
        } else if (!isValidFormat.boolValue) {
            return NSLocalizedString(@"Email format is invalid", @"");
        } else {
            return NSLocalizedString(@"Email looks good", @"");
        }
    }];
    
    _deliverable = [[[[[[[RACObserve(self, input) filter:^BOOL(id  _Nullable value) {
        @strongify(self);
        return [self.validator evaluate:value];
    }] throttle:0.3] filter:^BOOL(NSString *value) {
        return value.hasContent__NT;
    }] map:^RACSignal *(id value) {
        @strongify(self);
        return [self.http verifyEmail:value];
    }] switchToLatest] map:^id _Nullable(id  _Nullable value) {
        return [[ValidateResponse alloc] initWithAttributes:value];
    }] map:^id _Nullable(ValidateResponse *value) {
        return @([value.result isEqualToString:@"deliverable"]);
    }];
    
    [self ensure];
    return self;
}

@end
