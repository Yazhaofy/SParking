//
//  SearchResultCell.m
//  uPaParking
//
//  Created by 张亚召 on 2017/10/17.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

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
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_topMargin);
        make.left.mas_equalTo(_imgView.mas_right).mas_offset(8);
        make.right.mas_equalTo(view.mas_rightMargin);
    }];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.bottom.mas_equalTo(view.mas_bottomMargin);
        make.left.mas_equalTo(_imgView.mas_right).mas_offset(8);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_distanceLabel.mas_right).mas_offset(8);
        make.top.mas_equalTo(_distanceLabel);
        make.bottom.mas_equalTo(_distanceLabel);
        make.width.mas_equalTo(0.75);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line.mas_right).mas_offset(8);
        make.top.mas_equalTo(_line);
        make.bottom.mas_equalTo(_line);
        make.right.mas_equalTo(_nameLabel);
    }];
    
    [_imgView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_distanceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_line setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [_nameLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    [_addressLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
