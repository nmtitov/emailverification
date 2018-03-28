//
//  Error.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "Error.h"

@implementation Error

+ (instancetype)projectConfigurationError {
    return [self errorWithDomain:ErrorDomain code:ProjectConfigurationError userInfo:@{
        NSLocalizedDescriptionKey: @"Project is not configured. Make sure file EmailVerification/ApiKeys/kickbox.txt exists and contains and API key"
    }];
}

+ (instancetype)requestError {
    return [self errorWithDomain:ErrorDomain code:RequestError userInfo:@{
        NSLocalizedDescriptionKey: @"Bad request"
    }];
}

+ (instancetype)serverError {
    return [self errorWithDomain:ErrorDomain code:ServerError userInfo:@{
        NSLocalizedDescriptionKey: @"Server error"
    }];
}

+ (instancetype)parserError {
    return [self errorWithDomain:ErrorDomain code:ParserError userInfo:@{
        NSLocalizedDescriptionKey: @"Parser error"
    }];
}

@end

NSString * const ErrorDomain = @"ErrorDomain";

NSInteger const ProjectConfigurationError = 0;
NSInteger const RequestError = 1;
NSInteger const ServerError = 2;
NSInteger const ParserError = 3;
