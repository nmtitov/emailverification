//
//  MasterViewModel.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterViewModel.h"
#import "EmailValidator.h"
#import <ReactiveObjC/RACEXTScope.h>

@interface MasterViewModel ()

@property (readonly, nonatomic) EmailValidator *validator;

@end

@implementation MasterViewModel

- (void)ensure {
    NSParameterAssert(self.validator);
    NSParameterAssert(self.isEmpty);
    NSParameterAssert(self.isValidFormat);
    NSParameterAssert(self.isValid);
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _validator = [[EmailValidator alloc] init];
    
    _isEmpty = [RACObserve(self, input) map:^id _Nullable(NSString * _Nullable value) {
        BOOL result = value.length == 0;
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
    
    [self ensure];
    return self;
}

@end
