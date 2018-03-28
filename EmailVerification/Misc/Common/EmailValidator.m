//
//  EmailValidator.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "EmailValidator.h"

@interface EmailValidator ()

@property(readonly, nonatomic, nonnull) NSPredicate *emailRegexPredicate;

@end

@implementation EmailValidator

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    /*
     General Email Regex (RFC 5322 Official Standard)
     See http://emailregex.com/
     */
    NSString *emailString = @"(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}"
                            @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
                            @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-"
                            @"z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5"
                            @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
                            @"9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
                            @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    _emailRegexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" argumentArray:@[emailString]];
    return self;
}

- (BOOL)evaluate:(NSString *)string {
    if (!string) {
        return false;
    }
    return [self.emailRegexPredicate evaluateWithObject:string];
}

@end
