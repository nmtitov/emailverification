//
//  SuggestionsDataSource.h
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ensurable.h"

@interface SuggestionsDataSource : NSObject <UITableViewDataSource, Ensurable>

@property (copy, nonatomic) NSString *input;

- (void)setController:(UITableViewController *)controller;

- (NSString *)itemAt:(NSInteger)index;

@end
