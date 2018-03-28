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

/*
 Using iOS palette colors.
 See https://developer.apple.com/ios/human-interface-guidelines/visual-design/color/
 */

+ (instancetype)email_verification__is_valid_text {
    return [UIColor colorWithHexString:@"5ddc64"];
}

+ (instancetype)email_verification__is_not_valid_text {
    return [UIColor colorWithHexString:@"f63939"];
}

@end
