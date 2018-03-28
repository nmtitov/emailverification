//
//  Http.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "Http.h"
#import "Error.h"
#import "NSString+TrimmedString__NT.h"
#import <ReactiveObjC/RACEXTScope.h>
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>

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
    _kickboxApiKey = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error].trimmedString__NT;
    if (!_kickboxApiKey) {
        @throw [Error projectConfigurationError];
    }
    
    // Configure manager
    NSURL *base = [NSURL URLWithString:@"https://api.kickbox.com/v2/"];
    NSParameterAssert(base);
    
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:base];
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [[AFNetworkActivityLogger sharedLogger] startLogging];

    [self ensure];
    return self;
}

- (RACSignal *)verifyEmail:(NSString *)email {
    NSParameterAssert(email);
    NSParameterAssert(self.kickboxApiKey);
    
    id parameters = @{
        @"email": email,
        @"apikey": self.kickboxApiKey
    };
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self.manager GET:@"verify" parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, NSDictionary *JSON) {
            ValidateResponse *item = [[ValidateResponse alloc] initWithAttributes:JSON];
            [subscriber sendNext:item];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            [subscriber sendError:error];
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
