//
//  ValidateResponse.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateResponse : NSObject

@property (nonatomic, assign) BOOL accept_all;
@property (nonatomic, copy) NSString *did_you_mean;
@property (nonatomic, assign) BOOL disposable;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL free;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, assign) BOOL role;
@property (nonatomic, assign) NSUInteger sendex;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *user;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end

/*

Reference response from the server

{
    "accept_all": false,
    "did_you_mean": "nmtitov@mail.ru",
    "disposable": false,
    "domain": "gmail.ru",
    "email": "nmtitov@gmail.ru",
    "free": false,
    "message": null,
    "reason": "invalid_domain",
    "result": "undeliverable",
    "role": false,
    "sendex": 0,
    "success": true,
    "user": "nmtitov"
}

*/
