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
#import <ReactiveObjC/RACEXTScope.h>

@interface MasterViewModel ()

@property (readonly, nonatomic) EmailValidator *validator;

@property (readonly, nonatomic) RACSignal *isEmpty;
@property (readonly, nonatomic) RACSignal *isValidFormat;

@end

@implementation MasterViewModel

- (void)ensure {
    NSParameterAssert(self.validator);
    NSParameterAssert(self.isEmpty);
    NSParameterAssert(self.isValidFormat);
    
    NSParameterAssert(self.isValid);
    NSParameterAssert(self.status);
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _validator = [[EmailValidator alloc] init];
    
    _isEmpty = [RACObserve(self, input) map:^id _Nullable(NSString * _Nullable value) {
        BOOL result = value.isEmpty__NT;
        return @(result);
    }];

    @weakify(self);
    _isValidFormat = [RACObserve(self, input) map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        if (!value) {
            return false;
        }
        BOOL result = [self.validator evaluate:value];
        return @(result);
    }];
    
    _isValid = [[RACSignal combineLatest:@[self.isEmpty.not, self.isValidFormat]] map:^(RACTuple *tuple) {
        BOOL result = [tuple.rac_sequence all:^(NSNumber *value) {
            return value.boolValue;
        }];
        return @(result);
    }];
    
    _status = [RACSignal combineLatest:@[self.isEmpty, self.isValidFormat]
        reduce:^NSString *(NSNumber *isEmpty, NSNumber *isValidFormat) {
            if (isEmpty.boolValue) {
                return NSLocalizedString(@"Email is empty", @"");
            } else if (!isValidFormat.boolValue) {
                return NSLocalizedString(@"Email format is invalid", @"");
            } else {
                return NSLocalizedString(@"Email looks good", @"");
            }
        }];
    
    [self ensure];
    return self;
}

@end
