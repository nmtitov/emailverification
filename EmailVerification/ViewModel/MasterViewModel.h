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

@property (readonly, nonatomic) RACSignal *isValid;
@property (readonly, nonatomic) RACSignal *status;
@property (readonly, nonatomic) RACSignal *deliverable;

- (instancetype)initWithHttp:(Http *)http NS_DESIGNATED_INITIALIZER;

@end
