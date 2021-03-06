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
#import "Http.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _http = [[Http alloc] init];
    [self configureRootController];
    
    return YES;
}

- (void)configureRootController {
    UINavigationController *navigation = (UINavigationController *)self.window.rootViewController;
    MasterController *controller = (MasterController *)navigation.topViewController;
    
    NSParameterAssert(navigation);
    NSParameterAssert(controller);
    
    controller.viewModel = [[MasterViewModel alloc] initWithHttp:self.http];
}

@end
