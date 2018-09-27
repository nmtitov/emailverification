//
//  SuggestionsDelegate.h
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestionsSelectionDelegate.h"

@interface SuggestionsDelegate : NSObject <UITableViewDelegate>

@property(weak, nonatomic) id<SuggestionsSelectionDelegate> delegate;

@end
