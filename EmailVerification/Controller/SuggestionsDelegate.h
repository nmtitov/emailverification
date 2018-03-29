//
//  SuggestionsDelegate.h
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ensurable.h"
#import "SuggestionsSelectionDelegate.h"

@class MasterController, SuggestionsDataSource;
@interface SuggestionsDelegate : NSObject <UITableViewDelegate, Ensurable>

@property(weak, nonatomic) SuggestionsDataSource *dataSource;
@property(weak, nonatomic) id<SuggestionsSelectionDelegate> delegate;

@end
