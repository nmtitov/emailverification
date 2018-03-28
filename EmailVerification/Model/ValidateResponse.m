//
//  ValidateResponse.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "ValidateResponse.h"

@implementation ValidateResponse

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.accept_all = (BOOL)[[attributes valueForKeyPath:@"accept_all"] boolValue];
    self.did_you_mean = [attributes valueForKeyPath:@"did_you_mean"];
    self.disposable = (BOOL)[[attributes valueForKeyPath:@"disposable"] boolValue];
    self.domain = [attributes valueForKeyPath:@"domain"];
    self.email = [attributes valueForKeyPath:@"email"];
    self.free = (BOOL)[[attributes valueForKeyPath:@"free"] boolValue];
    self.message = [attributes valueForKeyPath:@"message"];
    self.reason = [attributes valueForKeyPath:@"reason"];
    self.result = [attributes valueForKeyPath:@"result"];
    self.role = (BOOL)[[attributes valueForKeyPath:@"role"] boolValue];
    self.sendex = (NSUInteger)[[attributes valueForKeyPath:@"sendex"] integerValue];
    self.success = (BOOL)[[attributes valueForKeyPath:@"success"] boolValue];
    self.user = [attributes valueForKeyPath:@"user"];

    return self;
}

@end
