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
#import "SuggestionsSelectionDelegate.h"

@interface MasterController : UIViewController <Ensurable, NTStringIdentifier, SuggestionsSelectionDelegate>

@property (strong, nonatomic) MasterViewModel *viewModel;

@end
