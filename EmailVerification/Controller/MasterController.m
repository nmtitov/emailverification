//
//  MasterController.m
//  EmailVerification
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "MasterController.h"
#import "SuggestionsController.h"
#import "SuggestionsDataSource.h"
#import "Ensurable.h"
#import "NSString+TrimmedString__NT.h"
#import "UIColor+EmailVerification.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>

@interface MasterController ()<UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *inputTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) SuggestionsController *tableController;

@end

@implementation MasterController

- (void)ensure {
    NSParameterAssert(self.inputTextField);
    NSParameterAssert(self.statusLabel);
    NSParameterAssert(self.tableController);
    NSParameterAssert(self.viewModel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableController.tableView.delegate = self;
    [self ensure];
    [self bind];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.inputTextField becomeFirstResponder];
}

- (void)bind {
    RACSignal *input = [self.inputTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return value.trimmedString__NT;
    }];
    RAC(self, viewModel.input) = input;
    @weakify(self);
    [input subscribeNext:^(NSString *value) {
        @strongify(self);
        [self.tableController showSuggestionsForInput:value];
    }];
    RAC(self, statusLabel.text) = self.viewModel.status;
    RAC(self, statusLabel.textColor) = [self.viewModel.isValid map:^UIColor *(NSNumber *value) {
        return value.boolValue ? UIColor.email_verification__is_valid_text : UIColor.email_verification__is_not_valid_text;
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SuggestionsDataSource *dataSource = (SuggestionsDataSource *)tableView.dataSource;
    NSString *suggestion = [dataSource itemAt:indexPath.row];
    NSString *current = self.inputTextField.text.trimmedString__NT;
    NSRange range = [current rangeOfString:@"@"];
    if (range.location != NSNotFound) {
        NSUInteger location = range.location + 1;
        NSString *substring = [current substringToIndex:location];
        NSString *new = [NSString stringWithFormat:@"%@%@", substring, suggestion];
        self.inputTextField.text = new;
        [self.inputTextField sendActionsForControlEvents:UIControlEventAllEvents];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = segue.identifier;
    NSParameterAssert(identifier);
    
    if ([identifier isEqualToString:SuggestionsController.stringIdentifier]) {
        SuggestionsController *controller = (SuggestionsController *)segue.destinationViewController;
        NSParameterAssert(controller);
        
        self.tableController = controller;
    } else {
        NSString *message = [NSString stringWithFormat:@"Unknown segue identifier, you should write a handler first: %@", identifier];
        NSAssert(false, message);
    }
}

@end
