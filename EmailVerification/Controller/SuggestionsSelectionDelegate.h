//
//  SuggestionsSelectionDelegate.h
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SuggestionsSelectionDelegate <NSObject>

- (void)didSelectSuggestion:(NSString *)suggestion;

@end
