//
//  Http.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Ensurable.h"
#import "ValidateResponse.h"

@interface Http : NSObject <Ensurable>

@property (readonly, strong, nonatomic) AFHTTPSessionManager *manager;

- (RACSignal *)verifyEmail:(NSString *)email;

@end
