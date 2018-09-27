//
//  SuggestionsController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsController.h"

@implementation SuggestionsController

- (void)ensure {
    // IB
    NSParameterAssert(self.dataSourceObject);
    NSParameterAssert(self.delegateObject);
    NSParameterAssert(self.tableView.dataSource);
    NSParameterAssert(self.tableView.delegate);
    // Child
    [self.dataSourceObject ensure];
    [self.delegateObject ensure];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.delegateObject setDataSource:self.dataSourceObject];
    [self ensure];
}

- (void)showSuggestionsForInput:(NSString *)input {
    [self.dataSourceObject loadSuggestionsForInput:input];
    [self.tableView reloadData];
}

@end
