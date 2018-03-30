//
//  MasterViewModel.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Ensurable.h"
#import "Http.h"

@interface MasterViewModel : NSObject <Ensurable>

@property (readonly, nonatomic) Http *http;
@property (copy, nonatomic) NSString *input;

@property (readonly, nonatomic) RACSignal *isDeliverable; // Stream of boolean values
@property (readonly, nonatomic) RACSignal *isValid; // Stream of boolean values
@property (readonly, nonatomic) RACSignal *status; // Stream of strings

- (instancetype)initWithHttp:(Http *)http NS_DESIGNATED_INITIALIZER;

@end
