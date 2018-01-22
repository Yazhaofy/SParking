//
//  ParkingLot.m
//  SParking
//
//  Created by Yazhao on 2018/1/17.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "ParkingLot.h"

@implementation ParkingLot
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self=[self init];
    if(self){
        NSString *parkId=dict[@"id"];
        NSString *name=dict[@"name"];
        NSString *address=dict[@"address"];
        CLLocationDegrees lat=[dict[@"latitude"]doubleValue];
        CLLocationDegrees lng=[dict[@"longitude"]doubleValue];

        NSInteger total=[dict[@"spaceNum"]integerValue];
        NSInteger totalShared=[dict[@"sharingSpaceNum"]integerValue];
        NSInteger empty=[dict[@"emptySharingSpaceNum"]integerValue];
        
        _parkId=parkId;
        _name=name;
        _address=address;
        _pt=CLLocationCoordinate2DMake(lat, lng);
        _numberOfAllSpace=total;
        _numberOfSharedSpace=totalShared;
        _numberOfUsableSpace=empty;
    }
    return self;
}
@end
