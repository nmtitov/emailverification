//
//  NSString+isMatching__NT.h
//  Nikita Titov
//
//  Created by Nikita Titov on 13/05/15.
//  Copyright (c) 2015 Nikita Titov. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSString (isMatching__NT)

- (BOOL)isMatching__NT:(NSString *)regex;
- (BOOL)isMatchingCaseInsensitive__NT:(NSString *)regex;

@end
