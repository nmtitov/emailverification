//
//  SuggestionsController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsController.h"
#import "SuggestionsDelegate.h"

@interface SuggestionsController ()

@property (strong, nonatomic) IBOutlet SuggestionsDelegate *delegateObject;

@end

@implementation SuggestionsController

- (void)ensure {
    // IB
    NSParameterAssert(self.dataSourceObject);
    NSParameterAssert(self.delegateObject);
    NSParameterAssert(self.tableView.dataSource);
    NSParameterAssert(self.tableView.delegate);
    // Child
    [self.dataSourceObject ensure];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSourceObject setController:self];
    [self ensure];
}

@end
