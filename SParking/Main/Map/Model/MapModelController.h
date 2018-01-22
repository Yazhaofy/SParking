//
//  MapModelController.h
//  SParking
//
//  Created by Yazhao on 2018/1/12.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchResult;

@protocol MapModelControllerDelegate;
@interface MapModelController : NSObject
@property(nonatomic,weak)id<MapModelControllerDelegate> delegate;

@property(nonatomic,assign)CLLocationCoordinate2D mapCenter;
@property(nonatomic,strong)BMKPointAnnotation *mapCenterAnn;

@property(nonatomic,strong)BMKPoiSearch *poiSearch;
@property(nonatomic,strong)NSArray *searchResults;

-(void)findParkAround:(CLLocationCoordinate2D)pt completion:(void (^)(NSArray *dataList, NSError *error))completion;
@end

@protocol MapModelControllerDelegate <NSObject>
@end
