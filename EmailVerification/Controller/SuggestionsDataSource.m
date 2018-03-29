
//
//  SuggestionsDataSource.m
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsDataSource.h"
#import "Error.h"
#import "NSString+TrimmedString__NT.h"

@interface SuggestionsDataSource ()

@property (strong, nonatomic) NSArray *all;
@property (strong, nonatomic) NSArray *top;

@end

@implementation SuggestionsDataSource

- (void)ensure {
    NSParameterAssert(self.all);
    NSParameterAssert(self.top);
    NSParameterAssert(self.input);
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Get API key
    NSURL *url = [NSBundle.mainBundle URLForResource:@"free" withExtension:@"txt"];
    if (![NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        @throw [Error projectConfigurationError];
    }
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error].trimmedString__NT;
    if (!string) {
        @throw [Error projectConfigurationError];
    }
    NSArray *domains = [string componentsSeparatedByString:@"\n"];
    self.all = domains;
    
    self.top = @[
        @"gmail.com",
        @"yahoo.com",
        @"yandex.ru",
        @"mail.ru"
    ];
    
    self.input = @"";
    
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
