//
//  SuggestionsCell.h
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTStringIdentifier.h"

@interface SuggestionsCell : UITableViewCell <NTStringIdentifier>

@property (copy, nonatomic) NSString *title;

@end
