//
//  SuggestionsController.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ensurable.h"
#import "NSObject+NTStringIdentifier.h"
#import "SuggestionsDataSource.h"
#import "SuggestionsDelegate.h"

@interface SuggestionsController : UITableViewController <Ensurable, NTStringIdentifier>

@property (strong, nonatomic) IBOutlet SuggestionsDataSource *dataSourceObject;
@property (strong, nonatomic) IBOutlet SuggestionsDelegate *delegateObject;

@end
