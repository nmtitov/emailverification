//
//  NSString+isEmpty__NT.m
//  Nikita Titov
//
//  Created by Nikita Titov on 13/05/15.
//  Copyright (c) 2015 Nikita Titov. All rights reserved.
//


#import "NSString+isEmpty__NT.h"
#import "NSString+isMatching__NT.h"


@implementation NSString (isEmpty__NT)

- (BOOL)isEmpty__NT;
{
    if (self.length == 0) {
        return YES;
    }
    // if string consists of whitespaces, it is empty
    else if ([self isMatching__NT:@"^\\s+$"]) {
        return YES;
    }
    return NO;
}

@end
