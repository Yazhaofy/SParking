//
//  LoginViewFooter.m
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LoginViewFooter.h"

@implementation LoginViewFooter
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [_forgetPasswdButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    
    _loginButton.backgroundColor=ThemeColor;
    
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithAttributedString:_registerButton.currentAttributedTitle];
    [attrStr setAttributes:@{NSForegroundColorAttributeName:UIColor.darkGrayColor} range:(NSRange){0,@"没有密码？立即".length}];
    [attrStr setAttributes:@{NSForegroundColorAttributeName:ThemeColor} range:(NSRange){@"没有密码？立即".length,@"注册".length}];
}
@end
