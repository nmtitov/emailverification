//
//  MasterController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterController.h"
#import "Ensurable.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MasterController ()

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *inputTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MasterController

- (void)ensure {
    // IB
    NSParameterAssert(self.inputTextField);
    NSParameterAssert(self.errorLabel);
    // Dependencies
    NSParameterAssert(self.viewModel);
}

- (void)setViewModel:(MasterViewModel *)viewModel {
    _viewModel = viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ensure];
    [self bind];
    [self subscribe];
}

- (void)bind {
    RAC(self, viewModel.input) = self.inputTextField.rac_textSignal;
}

- (void)subscribe {
    RAC(self, errorLabel.textColor) = [self.viewModel.valid map:^UIColor *(NSNumber *value) {
        return value.boolValue ? UIColor.greenColor : UIColor.redColor;
    }];
}

@end
