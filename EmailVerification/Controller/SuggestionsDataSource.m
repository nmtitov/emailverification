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

@interface DomainHelper : NSObject

+ (NSArray *)domains;
+ (NSArray *)top;

@end

@implementation DomainHelper

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
    _all = [DomainHelper domains];
    _top = [DomainHelper top];
    
    return self;
}

- (void)loadSuggestionsForInput:(NSString *)input {
    [self.suggested removeAllObjects];
    
    NSRange range = [input rangeOfString:@"@"];
    if (range.location != NSNotFound) {
        NSString *substring = [input substringFromIndex:range.location + 1];
        if (substring.isEmpty__NT) {
            [self.suggested addObjectsFromArray:self.top];
        } else {
            for (NSString *domain in self.all) {
                if ([domain hasPrefix:substring] && ![domain isEqualToString:substring]) {
                    [self.suggested addObject:domain];
                }
            }
        }
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
    if (section == 0) {
        return [self numberOfItems] == 0 ? nil : NSLocalizedString(@"Suggestions", @"");
    }
    return nil;
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
