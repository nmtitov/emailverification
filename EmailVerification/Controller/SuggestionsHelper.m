//
//  SuggestionsHelper.m
//  EmailVerification
//
//  Created by Nikita Titov on 27/09/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsHelper.h"
#import "NSString+TrimmedString__NT.h"
#import "Error.h"

@implementation SuggestionsHelper

+ (NSArray *)domains {
    NSURL *url = [NSBundle.mainBundle URLForResource:@"free" withExtension:@"txt"];
    if (![NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        @throw [Error projectConfigurationError];
    }
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error].trimmedString__NT;
    if (!string) {
        @throw [Error projectConfigurationError];
    }
    return [string componentsSeparatedByString:@"\n"];
}

+ (NSArray *)top {
    return @[
        @"gmail.com",
        @"yahoo.com",
        @"yandex.ru",
        @"mail.ru"
    ];
}

@end
