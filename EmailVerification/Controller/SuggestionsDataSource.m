//
//  SuggestionsDataSource.m
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsDataSource.h"
#import "NSString+hasContent__NT.h"
#import "NSString+isMatching__NT.h"
#import "SuggestionsCell.h"
#import "SuggestionsHelper.h"

@interface SuggestionsDataSource ()

@property (strong, nonatomic) NSMutableArray *suggested;

@property (strong, nonatomic) NSArray *all;
@property (strong, nonatomic) NSArray *top;

@end

@implementation SuggestionsDataSource

- (void)ensure {
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
    _all = [SuggestionsHelper domains];
    _top = [SuggestionsHelper top];
    
    return self;
}

- (void)loadSuggestionsForInput:(NSString *)input {
    [self.suggested removeAllObjects];
    
    NSRange range = [input rangeOfString:@"@"];
    if (range.location == NSNotFound) {
        return;
    }
    NSString *substring = [input substringFromIndex:range.location + 1];
    if (substring.hasContent__NT) {
        for (NSString *domain in self.all) {
            if ([domain hasPrefix:substring] && ![domain isEqualToString:substring]) {
                [self.suggested addObject:domain];
            }
        }
    } else {
        [self.suggested addObjectsFromArray:self.top];
    }
}

#pragma mark - Helper

- (NSInteger)numberOfItems {
    return self.suggested.count;
}

- (NSString *)itemAt:(NSInteger)index {
    return self.suggested[index];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self numberOfItems] == 0 ? nil : NSLocalizedString(@"Suggestions", @"");
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SuggestionsCell *cell = (SuggestionsCell *)[tableView dequeueReusableCellWithIdentifier:@"SuggestionsCell" forIndexPath:indexPath];
    cell.title = [self itemAt:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfItems];
}

@end
