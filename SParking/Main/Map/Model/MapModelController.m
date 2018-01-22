//
//  MapModelController.m
//  SParking
//
//  Created by Yazhao on 2018/1/12.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "MapModelController.h"
#import "SearchResult.h"
#import "ParkingLot.h"

@implementation MapModelController

-(BMKPoiSearch*)poiSearch{
    if(!_poiSearch){
        _poiSearch=[[BMKPoiSearch alloc]init];
    }
    return _poiSearch;
}

-(NSArray*)searchResults{
    if(!_searchResults){
        NSUserDefaults *uds=[NSUserDefaults standardUserDefaults];
        _searchResults=[uds objectForKey:@"HistorySearches"];
    }
    return _searchResults;
}
-(void)findParkAround:(CLLocationCoordinate2D)pt completion:(void (^)(NSArray *, NSError *))completion{
    NetworkManager *manager=[NetworkManager manager];
    manager.path=@"NearbyParkingsList";
    manager.params=@{@"Center":[NSString stringWithFormat:@"%f,%f",pt.longitude,pt.latitude],@"Distance":@5};
    manager.method=@"POST";
    
    manager.response = ^(NSDictionary *info, NSError *error) {
        if(error){
            completion(nil,error);
            return;
        }
        
        NSInteger code=[info[@"code"]integerValue];
        if(code){
            NSLog(@"%@",info[@"msg"]);
            return;
        }
        
        //正常返回数据
        NSMutableArray *dataList=nil;
        NSArray *result=info[@"result"];
        if(result){
            dataList=[[NSMutableArray alloc]init];
            for (NSDictionary *dict in result) {
                ParkingLot *lot=[[ParkingLot alloc]initWithDictionary:dict];
                [dataList addObject:lot];
            }
        }
        
        completion(dataList,nil);
    };
    [manager startRequest];
}
@end
