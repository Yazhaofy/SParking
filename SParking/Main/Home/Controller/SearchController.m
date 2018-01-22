//
//  SearchController.m
//  SParking
//
//  Created by Yazhao on 2018/1/19.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "SearchController.h"
#import "HomeViewController.h"

#import "SearchResultCell.h"

#import "LocationService.h"

#import "HomeModelController.h"


static NSString * const cellIdentifier = @"cellIdentifier";

@interface SearchController ()<UISearchBarDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)BMKPoiSearch *poiSearch;
@property(nonatomic,strong)NSString *searchText;

@property(nonatomic,assign)BOOL isTableViewShown;

@property(nonatomic,strong)HomeModelController *modelController;
@end

@implementation SearchController
-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self=[super initWithSearchResultsController:searchResultsController];
    if(self){
        [self initialization];
    }
    return self;
}

-(HomeModelController*)modelController{
    if(!_modelController){
        _modelController=[[HomeModelController alloc]init];
    }
    return _modelController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MARK - 初始化设置
-(void)initialization{
    self.obscuresBackgroundDuringPresentation=NO;

    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"home_search_field_bkg"] forState:UIControlStateNormal];
    
    //设置占位符
    self.searchBar.placeholder= @"搜索目的地...";
    self.searchBar.delegate = self;
    self.poiSearch.delegate=self;
}

#pragma mark - UI元素
-(UITableView*)tableView{
    if(!_tableView){
        _tableView=[[UITableView alloc]init];
        _tableView.backgroundColor=UIColor.whiteColor;
        _tableView.tableFooterView=UIView.new;
        _tableView.hidden=YES;
        _tableView.estimatedRowHeight=44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        
        UINib *resultNib=[UINib nibWithNibName:@"SearchResultCell" bundle:nil];
        [_tableView registerNib:resultNib forCellReuseIdentifier:cellIdentifier];
        
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
-(BMKPoiSearch*)poiSearch{
    if(!_poiSearch){
        _poiSearch=[[BMKPoiSearch alloc]init];
    }
    return _poiSearch;
}
-(NSArray*)dataSource{
    if(!_dataSource){
        _dataSource=self.modelController.historySearches;
    }
    return _dataSource;
}

#pragma mark - 位置搜索和停车场搜索
-(void)poiSearchByKeyword:(NSString*)keyword pageIndex:(int)index{
    BMKCitySearchOption *option=[[BMKCitySearchOption alloc]init];
    option.city=LocationService.sharedService.userLocalCity;
    option.requestPoiAddressInfoList=NO;
    option.pageIndex=index;
    option.pageCapacity=20;
    
    option.keyword=keyword;
    [self.poiSearch poiSearchInCity:option];
}
-(void)sParkingSearchNearby{
    
}

#pragma mark - search bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [searchBar setShowsCancelButton:YES animated:YES];
        for (id obj in [searchBar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                    }
                }
            }
        }
    });
    
    //搜索框内有内容的话显示搜索列表，没有内容的话显示历史搜索
    self.tableView.hidden=NO;
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _searchText=searchText;
    
    //搜索关键字
    if(_searchText.length>0){
        [self poiSearchByKeyword:_searchText pageIndex:0];
        return;
    }
    
    //清空搜索结果，只显示历史搜索
    _dataSource=nil;
    [self.tableView reloadData];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _searchText=nil;
    _dataSource=nil;
    
    [self.tableView reloadData];
    self.tableView.hidden=YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //保存搜索记录
    NSString *keyword=searchBar.text;
    
    //要保存的数据
    NSDictionary *object=@{@"name":keyword};
    
    [self.modelController saveHistorySearch:object];
}


#pragma mark - Poi search delegate
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    switch (errorCode) {
        case BMK_SEARCH_NO_ERROR:
            _dataSource=poiResult.poiInfoList;
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger dataCount=self.dataSource.count;
    if(dataCount<=0){
        tableView.hidden=YES;
        return 0;
    }
    
    return dataCount;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    id result=_dataSource[indexPath.row];
    
    //设置单元格
    if([result isKindOfClass:NSDictionary.class]){
        NSDictionary *info=(NSDictionary*)result;
        
        if(info[@"address"]){
            cell.imgView.image=[UIImage imageNamed:@"home_search_result_point"];
            
            cell.nameLabel.text=info[@"name"];
            
            CLLocationDegrees lat=[info[@"lat"]doubleValue];
            CLLocationDegrees lng=[info[@"lng"]doubleValue];
            CLLocationCoordinate2D pt=CLLocationCoordinate2DMake(lat, lng);
            cell.distanceLabel.text=[LocationService.sharedService distanceStringToPoint:pt];
            
            cell.addressLabel.text=info[@"address"];
            
            cell.line.hidden=NO;
        }else{
            cell.imgView.image=[UIImage imageNamed:@"home_search_result_search"];
            
            cell.nameLabel.text=info[@"name"];
            cell.distanceLabel.text=@"";
            cell.addressLabel.text=@"";
            
            cell.line.hidden=YES;
        }
        
        return cell;
    }

    //poiInfo或poiAddressInfo
    BMKPoiInfo *info=(BMKPoiInfo*)result;
    
    cell.imgView.image=[UIImage imageNamed:@"home_search_result_point"];
    cell.nameLabel.text=info.name;
    
    cell.distanceLabel.text=[LocationService.sharedService distanceStringToPoint:info.pt];
    cell.addressLabel.text=info.address;
    cell.line.hidden=NO;
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id result=_dataSource[indexPath.row];
    
    CLLocationCoordinate2D pt;
    
    //result如果是字典，则表示历史搜索
    if([result isKindOfClass:NSDictionary.class]){
        NSDictionary *info=(NSDictionary*)result;
        
        _searchText=info[@"name"];
        self.searchBar.text=_searchText;
        
        //没有地址值表示只记录了关键字，需根据关键字搜索POi信息
        if(!info[@"address"]){
            NSString *keyword=info[@"name"];
            
            //更新保存的数据
            [self.modelController saveHistorySearch:info];
            
            //搜索关键字信息
            [self poiSearchByKeyword:keyword pageIndex:0];
            return;
        }
        
        //选中历史搜索中的POI信息行
        pt=CLLocationCoordinate2DMake([info[@"lat"]doubleValue], [info[@"lng"]doubleValue]);
    }else{
        //选中搜索中的POI信息行
        BMKPoiInfo *info=(BMKPoiInfo*)result;
        
        _searchText=info.name;
        self.searchBar.text=_searchText;
        pt=info.pt;
        
        NSDictionary *obj=@{@"name":info.name,@"address":info.address,@"lat":@(info.pt.latitude),@"lng":@(info.pt.longitude)};
        [self.modelController saveHistorySearch:obj];
    }
    
    //地图上显示pt周边停车场
    [self.modelController findParkAround:pt completion:^(NSArray *dataList, NSError *error) {
        _parkingLots=dataList;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.hidden=YES;
        });
    }];
}
@end
