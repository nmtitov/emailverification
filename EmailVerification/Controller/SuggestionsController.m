//
//  SuggestionsController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsController.h"
#import "SuggestionsDataSource.h"
#import "SuggestionsDelegate.h"

@interface SuggestionsController ()

@property (strong, nonatomic) IBOutlet SuggestionsDataSource *dataSourceObject;
@property (strong, nonatomic) IBOutlet SuggestionsDelegate *delegateObject;

@end

@implementation SuggestionsController

- (void)ensure {
    NSParameterAssert(self.dataSourceObject);
    NSParameterAssert(self.delegateObject);
    NSParameterAssert(self.tableView.dataSource);
    NSParameterAssert(self.tableView.delegate);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ensure];
}

@end
