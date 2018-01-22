//
//  ParkingLot.h
//  SParking
//
//  Created by Yazhao on 2018/1/17.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkingLot : NSObject
@property(nonatomic,strong)NSString *parkId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,assign)CLLocationCoordinate2D pt;
@property(nonatomic,assign)NSInteger numberOfAllSpace;
@property(nonatomic,assign)NSInteger numberOfSharedSpace;
@property(nonatomic,assign)NSInteger numberOfUsableSpace;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
