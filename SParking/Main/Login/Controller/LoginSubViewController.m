//
//  LoginSubViewController.m
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LoginSubViewController.h"
#import "LoginViewFooter.h"
#import "LoginAccountCell.h"
#import "LoginPasswordCell.h"
#import "LoginSmsCodeCell.h"

@interface LoginSubViewController ()
@property (weak, nonatomic) UITextField *accountTextField;
@property (weak, nonatomic) UITextField *keyTextField;
@property (weak, nonatomic) UIImageView *keyImageView;
@property (weak, nonatomic) UIButton *keyCheckButton;

@end

@implementation LoginSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delaysContentTouches=NO;
    self.tableView.rowHeight=48;
    
    //添加手势点击屏幕关闭键盘
    [self viewAddGestureRecognizer];
    
    //注册界面元素
    [self tableRegistViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewAddGestureRecognizer{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.tableView addGestureRecognizer:tap];
}
-(void)dismissKeyboard{
    [self.tableView endEditing:YES];
}
-(void)tableRegistViews{
    UINib *nib=[UINib nibWithNibName:@"LoginViewFooter" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"Footer"];
    
    nib=[UINib nibWithNibName:@"LoginAccountCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LoginAccountCell"];
    
    nib=[UINib nibWithNibName:@"LoginPasswordCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LoginPasswordCell"];
    
    nib=[UINib nibWithNibName:@"LoginSmsCodeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LoginSmsCodeCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            LoginAccountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LoginAccountCell"];

            return cell;
        }
        case 1:{
            switch (_type) {
                case LoginTypePassword:{
                    LoginPasswordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LoginPasswordCell"];
                    return cell;
                }
                case LoginTypeSmsCode:{
                    LoginSmsCodeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LoginSmsCodeCell"];
                    return cell;
                }
                    
                default:
                    return nil;
            }
        }
            
        default:
            return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LoginViewFooter *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LoginViewFooter *footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    footer.forgetPasswdButton.hidden=_type;
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 148;
}
@end
