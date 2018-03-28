//
//  Error.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSError

+ (instancetype)projectConfigurationError;
+ (instancetype)requestError;
+ (instancetype)serverError;
+ (instancetype)parserError;

@end

FOUNDATION_EXPORT NSString * const ErrorDomain;

FOUNDATION_EXPORT NSInteger const ProjectConfigurationError;
FOUNDATION_EXPORT NSInteger const RequestError;
FOUNDATION_EXPORT NSInteger const ServerError;
FOUNDATION_EXPORT NSInteger const ParserError;

