//
//  UINavigationController+Custom.m
//  UParking
//
//  Created by 张亚召 on 2017/10/20.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import "UINavigationController+Custom.h"

@implementation UINavigationController(Custom)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏背景颜色
    [self.navigationBar setBarTintColor:ThemeColor];
    
    //设置字体及字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置背景没有半透明效果
    self.navigationBar.translucent=NO;
    
    [self.navigationBar setShadowImage:[UIImage new]];
}
@end
