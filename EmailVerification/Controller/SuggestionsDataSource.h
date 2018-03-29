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

- (void)setInput:(NSString *)input;

@end
