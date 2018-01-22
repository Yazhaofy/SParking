//
//  MapManager.h
//  SParking
//
//  Created by Yazhao on 2018/1/10.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapManager : NSObject
+(instancetype)defaultManager;

-(void)startMapService;
@end
