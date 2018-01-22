//
//  PersonalViewController.m
//  SParking
//
//  Created by Yazhao on 2018/1/10.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "PersonalViewController.h"
#import "LoginViewController.h"

@interface PersonalViewController ()
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIButton *packet;
@property (weak, nonatomic) IBOutlet UIButton *credit;
@property (weak, nonatomic) IBOutlet UIButton *carPlate;
@property (weak, nonatomic) IBOutlet UIButton *contact;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavigationBar{
    self.navigationItem.title=@"个人中心";
}
-(void)setupTableView{
    _header.backgroundColor=[UIColor orangeColor];
}
- (IBAction)didContactClicked:(UITapGestureRecognizer *)sender {
    UIViewController *loginVC=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
