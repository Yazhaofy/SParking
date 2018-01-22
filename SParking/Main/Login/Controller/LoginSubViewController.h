//
//  LoginSubViewController.h
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoginTypePassword,
    LoginTypeSmsCode,
} LoginTypeType;
@interface LoginSubViewController : UITableViewController
@property(nonatomic,assign)LoginTypeType type;
@end
