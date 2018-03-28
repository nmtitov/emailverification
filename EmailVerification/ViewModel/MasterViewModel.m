//
//  MasterViewModel.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterViewModel.h"

@implementation MasterViewModel

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _valid = [RACObserve(self, input) map:^id _Nullable(NSString * _Nullable value) {
        if (!value) {
            return false;
        }
        return @(value.length >= 5);
    }];
    return self;
}

@end
