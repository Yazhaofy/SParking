//
//  HomeModelController.m
//  SParking
//
//  Created by Yazhao on 2018/1/15.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "HomeModelController.h"
#import "ParkingLot.h"

#define HISTORT_BUFFER_MAX 20

NSString * const kHistorySearch = @"kHistorySearch";

@implementation HomeModelController

-(NSArray*)historySearches{
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    return [defaults objectForKey:kHistorySearch];
}

-(void)saveHistorySearch:(NSDictionary*)object{
    NSMutableDictionary *info=[NSMutableDictionary dictionaryWithDictionary:object];
    [info setValue:[NSDate date] forKey:@"date"];
    
    //读取已经保存的数据
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    NSArray *histories=[self historySearches];
    
    NSMutableArray *objArr=[NSMutableArray arrayWithArray:histories];
    if(!objArr){
        objArr=[[NSMutableArray alloc]init];
    }
    
    //删除之前的相同搜索
    for (NSDictionary *dic in objArr) {
        id isDicPoint=dic[@"address"];
        id isObjPoint=object[@"address"];
        
        BOOL isSameKind=(isDicPoint&&isObjPoint)||(!isObjPoint&&!isDicPoint) ? YES : NO;
        if([dic[@"name"] isEqual:object[@"name"]] && isSameKind){
            [objArr removeObject:dic];
            break;
        }
    }
    
    //缓存满则删除最早的
    if(objArr.count>=HISTORT_BUFFER_MAX){
        [objArr removeLastObject];
    }
    
    //添加当前搜索
    [objArr insertObject:info atIndex:0];
    
    //保存数据
    [defaults setObject:objArr forKey:kHistorySearch];
}

-(void)findParkAround:(CLLocationCoordinate2D)pt completion:(void (^)(NSArray *, NSError *))completion{
    NetworkManager *manager=[NetworkManager manager];
    manager.path=@"NearbyParkingsList";
    manager.params=@{@"Center":[NSString stringWithFormat:@"%f,%f",pt.longitude,pt.latitude],@"Distance":@5};
    manager.method=@"POST";
    
    manager.response = ^(NSDictionary *info, NSError *error) {
        if(error){
            NSLog(@"请求错误");
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
