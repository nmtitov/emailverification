//
//  MasterController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterController.h"
#import "Ensurable.h"
#import "NSString+TrimmedString__NT.h"
#import "UIColor+EmailVerification.h"
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
    RAC(self, viewModel.input) = [self.inputTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return value.trimmedString__NT;
    }];
}

- (void)subscribe {
//    RAC(self, errorLabel.text) = [self.viewModel ]
    RAC(self, errorLabel.textColor) = [self.viewModel.isValid map:^UIColor *(NSNumber *value) {
        return value.boolValue ? UIColor.email_verification__is_valid_text : UIColor.email_verification__is_not_valid_text;
    }];
}

@end
