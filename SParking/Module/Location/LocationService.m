//
//  LocationService.m
//  SParking
//
//  Created by TXiMac on 2018/1/5.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LocationService.h"

NSString *kUserLocationUpdatedNotification=@"kUserLocationUpdatedNotification";
NSString *kUserHeadingUpdatedNotification=@"kUserHeadingUpdatedNotification";
NSString *kUserLocalFailedNotification=@"kUserLocalFailedNotification";

@implementation LocationService
static LocationService *sharedService=nil;
+(instancetype)sharedService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService=[[self alloc]init];
        sharedService.headingFilter=60;
        sharedService.distanceFilter=3000;
        sharedService.delegate=sharedService;
    });
    return sharedService;
}

-(CLLocationDistance)distanceToPoint:(CLLocationCoordinate2D)pt{
    //经纬度坐标
    CLLocationCoordinate2D local=LocationService.sharedService.userLocation.location.coordinate;
    
    //经纬度转大地坐标
    BMKMapPoint localPoint=BMKMapPointForCoordinate(local);
    BMKMapPoint tarPoint=BMKMapPointForCoordinate(pt);
    
    return BMKMetersBetweenMapPoints(localPoint, tarPoint);
}
-(NSString*)distanceStringToPoint:(CLLocationCoordinate2D)pt{
    CLLocationDistance distance=[self distanceToPoint:pt];
    
    //数字转字符串
    NSString *distanceString=nil;
    if(distance<1000){//875m
        if(distance-floor(distance)<0.5){
            distance=floor(distance);
        }else{
            distance=ceil(distance);
        }
        
        distanceString=[NSString stringWithFormat:@"%.0fm",distance];
    }else if (distance){//1.2km
        CLLocationDistance kmDistance=distance/1000;
        if(kmDistance-floor(kmDistance)<0.1){
            distanceString=[NSString stringWithFormat:@"%.0fkm",kmDistance];
        }else{
            distanceString=[NSString stringWithFormat:@"%.1fkm",kmDistance];
        }
    }
    return distanceString;
}
#pragma mark - Location service delegate

-(void)willStartLocatingUser{
    
}
-(void)didStopLocatingUser{
    
}

-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"更新用户位置");
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    
    [clGeoCoder reverseGeocodeLocation:LocationService.sharedService.userLocation.location completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        for (CLPlacemark *placeMark in placemarks){
            NSDictionary *addressDic=placeMark.addressDictionary;
            _userLocalCity=[addressDic objectForKey:@"City"];
            break;
        }
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserLocationUpdatedNotification object:userLocation];
}

-(void)didFailToLocateUserWithError:(NSError *)error{
    
}
@end
