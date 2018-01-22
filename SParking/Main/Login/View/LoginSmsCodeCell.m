//
//  LoginSmsCodeCell.m
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LoginSmsCodeCell.h"

@implementation LoginSmsCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIView *view=self.contentView;
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_offset(15);
        make.top.mas_greaterThanOrEqualTo(view.mas_topMargin);
        make.bottom.mas_lessThanOrEqualTo(view.mas_bottomMargin);
        make.centerY.mas_equalTo(view);
    }];
    [_smsCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imgView.mas_right).mas_offset(8);
        make.top.mas_equalTo(view.mas_topMargin);
        make.bottom.mas_equalTo(view.mas_bottomMargin);
    }];
    [_smsCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_smsCodeTextField.mas_right).mas_offset(8);
        make.top.mas_greaterThanOrEqualTo(view.mas_topMargin);
        make.bottom.mas_lessThanOrEqualTo(view.mas_bottomMargin);
        make.centerY.mas_equalTo(_smsCodeTextField);
        make.right.mas_equalTo(view.mas_rightMargin);
    }];
    
    [_imgView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_smsCodeButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
//    [_line setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    
//    [_nameLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
//    [_addressLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
