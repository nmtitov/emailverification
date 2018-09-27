//
//  SuggestionsDelegate.m
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsDelegate.h"
#import "SuggestionsDataSource.h"

@implementation SuggestionsDelegate

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SuggestionsDataSource *dataSource = (SuggestionsDataSource *)tableView.dataSource;
    [self.delegate didSelectSuggestion:[dataSource itemAt:indexPath.row]];
}

@end
