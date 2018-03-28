//
//  Http.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "Http.h"
#import "Error.h"

@implementation Http

- (void)ensure {
    NSParameterAssert(self.manager);
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Get API key
    NSURL *url = [NSBundle.mainBundle URLForResource:@"kickbox" withExtension:@"txt"];
    if (![NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        @throw [Error projectConfigurationError];
    }
    NSError *error;
    NSString *kickboxApiKey = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (!kickboxApiKey) {
        @throw [Error projectConfigurationError];
    }
    
    // Configure manager
    NSURL *base = [NSURL URLWithString:@"https://api.kickbox.com/v2/"];
    NSParameterAssert(base);
    
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:base];
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [self ensure];
    return self;
}

@end
