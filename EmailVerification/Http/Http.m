//
//  Http.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "Http.h"
#import "Error.h"
#import <ReactiveObjC/RACEXTScope.h>

@interface Http ()

@property (readonly, copy, nonatomic) NSString *kickboxApiKey;

@end

@implementation Http

- (void)ensure {
    NSParameterAssert(self.manager);
    NSParameterAssert(self.kickboxApiKey);
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
    _kickboxApiKey = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (!_kickboxApiKey) {
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

- (NSURLSessionDataTask *)verifyWithBlock:(void (^)(NSDictionary *reseponse, NSError *error))block {
    NSParameterAssert(self.kickboxApiKey);
    
    id parameters = @{
        @"email": @"nmtitov@gmail.ru",
        @"apikey": self.kickboxApiKey
    };
    return [self.manager GET:@"verify" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        
        if (block) {
            block(nil, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

@end
