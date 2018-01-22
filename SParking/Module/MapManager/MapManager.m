//
//  MapManager.m
//  SParking
//
//  Created by Yazhao on 2018/1/10.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "MapManager.h"

#define BMK_APP_SN 10667730
#define BMK_APP_KEY @"sRH5DVA9D1psVYlXmnUycyjTTf0QwNWT"
@implementation MapManager
static MapManager *defaultManager=nil;
+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager=[[self alloc]init];
    });
    return defaultManager;
}
-(void)startMapService{
    BMKMapManager *manager=[[BMKMapManager alloc]init];
    [manager start:BMK_APP_KEY generalDelegate:nil];
}
@end
