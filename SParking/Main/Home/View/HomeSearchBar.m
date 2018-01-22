//
//  HomeSearchBar.m
//  SParking
//
//  Created by Yazhao on 2018/1/18.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "HomeSearchBar.h"

@implementation HomeSearchBar{
    UIView *_contentView;
    UIView *_leftView;
    UIImageView *_leftImageView;
}
-(UIView*)contentView{
    if(!_contentView){
        _contentView=[[UIView alloc]init];
        _contentView.backgroundColor=UIColor.whiteColor;
        _contentView.layer.cornerRadius=3.0f;
        _contentView.clipsToBounds=YES;

        [_contentView addSubview:self.textField];
        [_contentView addSubview:self.searchButton];
    }
    return _contentView;
}

-(UIButton*)searchButton{
    if(!_searchButton){
        _searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *nornalImg=[UIImage imageNamed:@"home_search_bar_mic"];
        [_searchButton setImage:nornalImg forState:UIControlStateNormal];
    }
    return _searchButton;
}
-(UITextField*)textField{
    if(!_textField){
        _textField=[[UITextField alloc]init];
        _textField.leftViewMode=UITextFieldViewModeAlways;
        _textField.leftView=self.leftView;
        _textField.placeholder=@"请输入目的地...";
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _textField;
}
-(UIView*)leftView{
    if(!_leftView){
        _leftView=[[UIView alloc]init];
        [_leftView addSubview:self.leftImageView];
        _leftView.bounds=(CGRect){0,0,32,0};
    }
    return _leftView;
}
-(UIImageView*)leftImageView{
    if(!_leftImageView){
        UIImage *img=[UIImage imageNamed:@"home_search_bar_search"];
        _leftImageView=[[UIImageView alloc]initWithImage:img];
    }
    return _leftImageView;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addSubview:self.contentView];
    [self makeConstraints];
}

-(void)makeConstraints{
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topMargin);
        make.bottom.mas_equalTo(self.mas_bottomMargin);
        make.left.mas_equalTo(self.mas_leftMargin);
        make.right.mas_equalTo(self.mas_rightMargin);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentView);
        make.bottom.mas_equalTo(_contentView);
        make.left.mas_equalTo(_contentView);
    }];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_leftView);
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textField.mas_right).mas_offset(8);
        make.top.mas_equalTo(_contentView);
        make.bottom.mas_equalTo(_contentView);
        make.right.mas_equalTo(_contentView);
    }];
    
    [_searchButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_textField setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}
@end
