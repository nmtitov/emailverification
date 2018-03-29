
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
#import "SuggestionsCell.h"

@interface SuggestionsDataSource ()

@property (strong, nonatomic) NSMutableArray *suggested;

@property (strong, nonatomic) NSArray *all;
@property (strong, nonatomic) NSArray *top;

@end

@implementation SuggestionsDataSource

- (void)ensure {
    NSParameterAssert(self.all);
    NSParameterAssert(self.top);
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
    
    return self;
}

- (void)setInput:(NSString *)input {
    _input = [input copy];
    [self.suggested removeAllObjects];
    if (input.isEmpty__NT) {
        [self.suggested addObjectsFromArray:self.top];
    } else {
        NSArray *matching = [self.all filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"BEGINSWITH[cd] %@", input]];
        [self.suggested addObjectsFromArray:matching];
    }
}

#pragma mark - UITableViewDataSource

- (NSString *)itemAt:(NSInteger)index {
    return self.suggested[index];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SuggestionsCell *cell = (SuggestionsCell *)[tableView dequeueReusableCellWithIdentifier:SuggestionsCell.stringIdentifier forIndexPath:indexPath];
    cell.title = [self itemAt:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suggested.count;
}

@end
