//
//  SuggestionsDelegate.m
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsDelegate.h"
#import "MasterController.h"
#import "SuggestionsDataSource.h"

@implementation SuggestionsDelegate

- (void)ensure {
    NSCParameterAssert(self.dataSource);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectSuggestion:[self.dataSource itemAt:indexPath.row]];
}

@end
