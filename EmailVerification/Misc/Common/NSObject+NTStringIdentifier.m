//
//  NSObject+NTStringIdentifier.m
//  EmailVerification
//
//  Created by Nikita Titov on 04/01/16.
//  Copyright © 2016 N. M. Titov. All rights reserved.
//

#import "NSObject+NTStringIdentifier.h"

@implementation NSObject (NTStringIdentifier)

+ (NSString *)stringIdentifier {
    static NSString *stringIdentifier;
    if (!stringIdentifier) {
        stringIdentifier = NSStringFromClass(self);
    }
    return stringIdentifier;
}

@end
