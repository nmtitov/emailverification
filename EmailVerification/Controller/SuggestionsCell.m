//
//  SuggestionsCell.m
//  EmailVerification
//
//  Created by Nikita Titov on 29/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import "SuggestionsCell.h"

@interface SuggestionsCell ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SuggestionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareForReuse];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    [self didSetTitle:title];
}

- (void)didSetTitle:(NSString *)newValue {
    self.titleLabel.text = newValue;
}

@end
