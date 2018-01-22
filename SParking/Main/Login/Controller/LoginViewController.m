//
//  LoginViewController.m
//  SParking
//
//  Created by Yazhao on 2018/1/11.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LoginViewController.h"
#import "DLTabedSlideView.h"
#import "DLFixedTabbarView.h"

#import "LoginSubViewController.h"

@interface LoginViewController ()<DLTabedSlideViewDelegate>
@property(nonatomic,strong)DLTabedSlideView *tabedSlideView;
@end

@implementation LoginViewController

-(DLTabedSlideView*)tabedSlideView{
    if(!_tabedSlideView){
        _tabedSlideView=[[DLTabedSlideView alloc]init];
        _tabedSlideView.backgroundColor=[UIColor lightGrayColor];
        _tabedSlideView.baseViewController = self;
        
        _tabedSlideView.tabbarHeight=44;
        _tabedSlideView.tabItemNormalColor = [UIColor blackColor];
        _tabedSlideView.tabItemSelectedColor = ThemeColor;
        _tabedSlideView.tabbarTrackColor = ThemeColor;

        _tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"login_tabbar_back"];
        _tabedSlideView.delegate=self;
        
        DLTabedbarItem *item0=[DLTabedbarItem itemWithTitle:@"密码登录"];
        DLTabedbarItem *item1=[DLTabedbarItem itemWithTitle:@"验证码登录"];
        _tabedSlideView.tabbarItems = @[item0,item1];
        
        [_tabedSlideView buildTabbar];
        _tabedSlideView.selectedIndex = 0;
    }
    return _tabedSlideView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setupNavigation];
    [self addSunviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavigation{
    self.navigationItem.title=@"登录";
}
-(void)addSunviews{
    [self.view addSubview:self.tabedSlideView];
    [_tabedSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view.safeAreaInsets);
    }];
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    LoginSubViewController *vc=[[LoginSubViewController alloc]initWithStyle:UITableViewStyleGrouped];
    vc.type=index;
    return vc;
}

@end
