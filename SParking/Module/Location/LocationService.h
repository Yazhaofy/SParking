//
//  LocationService.h
//  SParking
//
//  Created by TXiMac on 2018/1/5.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kUserLocationUpdatedNotification;
extern NSString *kUserHeadingUpdatedNotification;
extern NSString *kUserLocalFailedNotification;
@interface LocationService : BMKLocationService<BMKLocationServiceDelegate>
+(instancetype)sharedService;

@property(nonatomic,strong)NSString *userLocalCity;

-(CLLocationDistance)distanceToPoint:(CLLocationCoordinate2D)pt;
-(NSString*)distanceStringToPoint:(CLLocationCoordinate2D)pt;
@end
