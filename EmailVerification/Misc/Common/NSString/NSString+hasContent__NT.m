//
//  NSString+hasContent__NT.m
//  Nikita Titov
//
//  Created by Nikita Titov on 13/05/15.
//  Copyright (c) 2015 Nikita Titov. All rights reserved.
//


#import "NSString+hasContent__NT.h"
#import "NSString+isEmpty__NT.h"


@implementation NSString (hasContent__NT)

- (BOOL)hasContent__NT;
{
    return ![self isEmpty__NT];
}

@end
