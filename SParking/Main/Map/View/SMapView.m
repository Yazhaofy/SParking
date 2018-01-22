//
//  SMapVIew.m
//  SParking
//
//  Created by Yazhao on 2018/1/12.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "SMapView.h"

@implementation SMapView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        [self initialization];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self initialization];
    }
    return self;
}

-(void)initialization{
    self.mapType=BMKMapTypeStandard;
    self.isSelectedAnnotationViewFront=YES;
    self.showsUserLocation = YES;
    self.rotateEnabled=NO;
    //        _mapView.maxZoomLevel=20;
    self.zoomLevel=15;
    [self setShowMapPoi:YES];
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    //        displayParam.locationViewImgName= @"icon";//定位图标名称
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [self updateLocationViewWithParam:displayParam];
}
@end
