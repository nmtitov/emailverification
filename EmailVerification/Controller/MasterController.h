//
//  MasterController.h
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ensurable.h"
#import "MasterViewModel.h"
#import "Http.h"
#import "NSObject+NTStringIdentifier.h"

@interface MasterController : UIViewController <Ensurable, NTStringIdentifier>

@property (readonly, nonatomic) MasterViewModel *viewModel;

// Dependencies
- (void)setViewModel:(MasterViewModel *)viewModel;

@end
