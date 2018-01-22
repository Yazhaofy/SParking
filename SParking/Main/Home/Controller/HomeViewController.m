//
//  HomeViewController.m
//  SParking
//
//  Created by Yazhao on 2018/1/18.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchController.h"

#import "HomeMapView.h"

#import "HomeModelController.h"

@interface HomeViewController ()<BMKMapViewDelegate>
@property (strong, nonatomic) SearchController *searchController;

@property (weak, nonatomic) IBOutlet HomeMapView *mapView;
@property(nonatomic,strong)UITableView *tableView;

@property (strong, nonatomic) HomeModelController *modelController;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"空位停车";
    self.navigationItem.searchController=self.searchController;
    
    [self viewAddSubviews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _mapView.delegate=self;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    _mapView.delegate=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///////////////////////////////////////////////////////////////////
#pragma mark - 属性getter方法
-(HomeModelController*)modelController{
    if(!_modelController){
        _modelController=[[HomeModelController alloc]init];
    }
    return _modelController;
}
- (SearchController *)searchController{
    if (!_searchController){
        _searchController=[[SearchController alloc]initWithSearchResultsController:nil];
    }
    return _searchController;
}

-(void)viewAddSubviews{
    [self.view addSubview:self.searchController.tableView];
    [self.searchController.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

#pragma mark - 用户操作事件
- (IBAction)contactItemClicked:(UIBarButtonItem *)sender {
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc=[sb instantiateViewControllerWithIdentifier:@"PersonalViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)scanItemClicked:(UIBarButtonItem *)sender {
}

-(void)showPoiSearchingList{
    
}
-(void)hidePoiSearchingList{
    
}
-(void)showPoiResultList{
    
}
-(void)hidePoiResultList{
    
}
@end
