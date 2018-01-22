//
//  LaunchGuideManager.h
//  SParking
//
//  Created by Yazhao on 2018/1/8.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchGuideManager : NSObject
+(instancetype)sharedManager;

-(void)setupLaunchIntroduction;
@end
