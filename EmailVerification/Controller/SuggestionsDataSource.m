
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
#import "NSString+isEmpty__NT.h"
#import "NSString+isMatching__NT.h"
#import "SuggestionsCell.h"

@interface SuggestionsDataSource ()

@property (weak, nonatomic) UITableViewController *controller;
@property (strong, nonatomic) NSMutableArray *suggested;

@property (strong, nonatomic) NSArray *all;
@property (strong, nonatomic) NSArray *top;

@end

@implementation SuggestionsDataSource

- (void)ensure {
    NSParameterAssert(self.controller);
    NSParameterAssert(self.suggested);
    NSParameterAssert(self.all);
    NSParameterAssert(self.top);
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _suggested = [[NSMutableArray alloc] init];
    
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
    
    return self;
}

- (void)setController:(UITableViewController *)controller {
    _controller = controller;
}

- (void)setInput:(NSString *)input {
    _input = [input copy];
    [self.suggested removeAllObjects];
    
    NSRange range = [input rangeOfString:@"@"];
    if (range.location == NSNotFound) {
        NSLog(@"@ sign was not found, keep suggestions empty");
    } else {
        NSUInteger location = range.location + 1;
        NSLog(@"position %lu", (unsigned long)location);
        
        NSString *substring = [input substringFromIndex:location];
        if (substring.isEmpty__NT) {
            [self.suggested addObjectsFromArray:self.top];
        } else {
            for (NSString *domain in self.all) {
                if ([domain hasPrefix:substring]) {
                    [self.suggested addObject:domain];
                }
            }
        }
    }
    [self.controller.tableView reloadData];
}

- (NSString *)itemAt:(NSInteger)index {
    return self.suggested[index];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SuggestionsCell *cell = (SuggestionsCell *)[tableView dequeueReusableCellWithIdentifier:@"SuggestionsCell" forIndexPath:indexPath];
    cell.title = [self itemAt:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suggested.count;
}

@end
