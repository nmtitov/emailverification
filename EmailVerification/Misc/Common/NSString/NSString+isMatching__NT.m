//
//  NSString+isMatching__NT.m
//  Nikita Titov
//
//  Created by Nikita Titov on 13/05/15.
//  Copyright (c) 2015 Nikita Titov. All rights reserved.
//


#import "NSString+isMatching__NT.h"


@implementation NSString (isMatching__NT)

- (BOOL)isMatching__NT:(NSString *)regex;
{
    NSRange range = [self rangeOfString:regex options:NSRegularExpressionSearch];
    BOOL matches = range.location != NSNotFound;
    return matches;
}

- (BOOL)isMatchingCaseInsensitive__NT:(NSString *)regex;
{
    NSRange range = [self rangeOfString:regex options:NSRegularExpressionSearch | NSRegularExpressionCaseInsensitive];
    BOOL matches = range.location != NSNotFound;
    return matches;
}

@end
