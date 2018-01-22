//
//  LoginSmsCodeCell.h
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSmsCodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet SDCountDownButton *smsCodeButton;

@end
