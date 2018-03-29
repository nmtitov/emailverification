//
//  UIColor+EmailVerification.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "UIColor+EmailVerification.h"
#import <UIColor+HexString.h>

@implementation UIColor (EmailVerification)

+ (instancetype)email_verification__is_valid_text {
    return [UIColor colorWithHexString:@"15aa46"];
}

+ (instancetype)email_verification__is_not_valid_text {
    return [UIColor colorWithHexString:@"fa3e3d"];
}

@end
