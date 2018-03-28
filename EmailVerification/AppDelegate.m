//
//  AppDelegate.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewModel.h"
#import "MasterController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureRoot];
    return YES;
}

- (void)configureRoot {
    UINavigationController *navigation = (UINavigationController *)self.window.rootViewController;
    NSParameterAssert(navigation);

    MasterController *controller = (MasterController *)navigation.topViewController;    
    NSParameterAssert(controller);
    
    MasterViewModel *viewModel = [[MasterViewModel alloc] init];
    [controller setViewModel:viewModel];
}

@end
