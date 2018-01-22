//
//  MapViewController.m
//  SParking
//
//  Created by Yazhao on 2018/1/10.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "MapViewController.h"
#import "SMapView.h"
#import "MapModelController.h"

#import "SearchResultCell.h"
#import "YQMotionShadowView.h"

#import "SearchResult.h"
#import "ParkingLot.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)IBOutlet SMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *searchBar;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mapCover;


@property(nonatomic,strong)MapModelController *modelController;
@property(nonatomic,strong)NSArray *mapAnns;
@property(nonatomic,assign)BOOL isListShown;
@end

@implementation MapViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    
    if(_isSearch){
        [_searchTextField becomeFirstResponder];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //注册通知
    [self registerNotifications];
    
    self.mapView.delegate=self;
    self.modelController.poiSearch.delegate=self;

    self.navigationController.navigationBarHidden=YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.mapView.delegate=nil;
    self.modelController.poiSearch.delegate=nil;
    
    [self removeNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - end 视图控制器生命周期

#pragma mark - 属性getter方法
-(MapModelController*)modelController{
    if(!_modelController){
        _modelController=[[MapModelController alloc]init];
    }
    return _modelController;
}
#pragma end - 属性getter方法

#pragma mark - 加载完成后的一些设置
-(void)setupSubviews{
    _tableView.estimatedRowHeight=72;
    _tableView.rowHeight=UITableViewAutomaticDimension;
    _tableView.tableFooterView=[UIView new];
    
    UINib *nib=[UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"SearchResultCell"];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
}
#pragma mark - end 加载完成后的一些设置

- (IBAction)localButtonClicked:(UIButton *)sender {
    BMKLocationService *locationService=LocationService.sharedService;
    BMKUserLocation *usrLocation=locationService.userLocation;
    
    CLLocationCoordinate2D pt=usrLocation.location.coordinate;
    
    //设置缩放
    [_mapView setZoomLevel:15];
    
    //地图中心移动
    [_mapView setCenterCoordinate:pt animated:YES];
    
}


-(void)registerNotifications{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(userLocationUpdatedNotification:) name:kUserLocationUpdatedNotification object:nil];
}

-(void)removeNotifications{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:kUserLocationUpdatedNotification object:nil];
}

-(void)loadNearByParkings:(CLLocationCoordinate2D)pt{
    [self.modelController findParkAround:pt completion:^(NSArray *dataList, NSError *error) {
        NSMutableArray *anns=[[NSMutableArray alloc]init];
        for (ParkingLot *lot in dataList) {
            BMKPointAnnotation *ann=[[BMKPointAnnotation alloc]init];
            ann.coordinate=lot.pt;
            [anns addObject:ann];
        }
        [self performSelectorOnMainThread:@selector(updateMapAnnotations:) withObject:anns waitUntilDone:YES];
    }];
}

-(void)searchByKeyword:(NSString*)keyword pageIndex:(int)index{
    BMKCitySearchOption *option=[[BMKCitySearchOption alloc]init];
    option.city=LocationService.sharedService.userLocalCity;
    option.requestPoiAddressInfoList=YES;
    option.pageIndex=index;
    option.pageCapacity=20;

    option.keyword=keyword;
    [self.modelController.poiSearch poiSearchInCity:option];
}

-(void)updateMapAnnotations:(NSArray*)anns{
    [_mapView removeAnnotations:_mapAnns];
    
    _mapAnns=anns;
    [_mapView addAnnotations:anns];
}
-(void)userLocationUpdatedNotification:(NSNotification*)note{
    BMKLocationService *locationService=LocationService.sharedService;
    BMKUserLocation *usrLocation=locationService.userLocation;
    
    //更新用户位置
    [_mapView updateLocationData:usrLocation];
    
    CLLocationCoordinate2D pt=usrLocation.location.coordinate;
    //地图中心移动
    [_mapView setCenterCoordinate:pt animated:YES];
    
    //加载周围停车场
    [self loadNearByParkings:pt];
}

-(void)showResultList{
    _mapCover.alpha=0.7;
    _tableView.alpha=1.0;
    
    _isListShown=YES;
}
-(void)hideResultList{
    _mapCover.alpha=0;
    _tableView.alpha=0;
    _isListShown=NO;
}

- (IBAction)backButtonClicked:(UIButton *)sender {
    if(_isListShown){
        [self hideResultList];
        [self.view endEditing:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)waveButtonClicked:(TYFWaveButton *)sender {
    sender.hidden=YES;
    [_searchTextField becomeFirstResponder];
}

- (IBAction)mapCoverTapRecgnizer:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

#pragma mark - Text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.modelController.searchResults){
        [self showResultList];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchByKeyword:textField.text pageIndex:0];
    return YES;
}

#pragma Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelController.searchResults.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    id result=self.modelController.searchResults[indexPath.row];
    if([result isKindOfClass:NSDictionary.class]){
        NSDictionary *res=(NSDictionary*)result;
        cell.nameLabel.text=res[@"name"];
    }else{
        BMKPoiInfo *res=(BMKPoiInfo*)result;
        cell.nameLabel.text=res.name;
        
        cell.distanceLabel.text=[LocationService.sharedService distanceStringToPoint:res.pt];
        cell.addressLabel.text=res.address;
    }
    
//    SearchResult *result=self.modelController.searchResults[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //读取单元格数据
    id result=self.modelController.searchResults[indexPath.row];
    
    if([result isKindOfClass:NSDictionary.class]){
        NSDictionary *res=(NSDictionary*)result;
    }else{
        BMKPoiInfo *res=(BMKPoiInfo*)result;
    }
    
    [self hideResultList];
}
#pragma mark - Map view delegate
-(void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    //读取用户位置
    BMKUserLocation *usrLocation=LocationService.sharedService.userLocation;
    CLLocation *location=usrLocation.location;
    
    if(location){
        //更新用户位置
        [self.mapView updateLocationData:usrLocation];
        
        //用户位置移动到屏幕中心
        CLLocationCoordinate2D center=location.coordinate;
        [mapView setCenterCoordinate:center animated:YES];
        
        //获取屏幕中心附近的停车场
        [self loadNearByParkings:center];
    }
}
-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    //如果是用户自身位置的小蓝点，就什么也不做
    if([annotation isKindOfClass:[BMKUserLocation class]]){
        return nil;
    }
    
    BMKAnnotationView *anView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"ParingAnnView"];
    if(!anView){
        anView=[[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ParingAnnView"];
        anView.image=[UIImage imageNamed:@"map_ann_park"];
    }
    return anView;
}

#pragma mark - BMKPoiSearchDelegate
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    switch (errorCode) {
        case BMK_SEARCH_NO_ERROR:
            self.modelController.searchResults=poiResult.poiInfoList;
            if(self.modelController.searchResults){
                [self showResultList];
            }
            [_tableView reloadData];
            break;
            
        default:
            break;
    }
}

@end
