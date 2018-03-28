//
//  MasterController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterController.h"
#import "Ensurable.h"

@interface MasterController ()

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *inputTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MasterController

- (void)ensure {
    NSParameterAssert(self.inputTextField);
    NSParameterAssert(self.errorLabel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ensure];
}

@end
