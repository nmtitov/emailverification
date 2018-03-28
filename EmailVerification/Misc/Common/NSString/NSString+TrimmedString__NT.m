//
//  NSString+TrimmedString.m
//  Nikita Titov
//
//  Created by Nikita Titov on 13/05/15.
//  Copyright (c) 2015 Nikita Titov. All rights reserved.
//


#import "NSString+TrimmedString__NT.h"


@implementation NSString (TrimmedString__NT)

- (instancetype)trimmedString__NT {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
