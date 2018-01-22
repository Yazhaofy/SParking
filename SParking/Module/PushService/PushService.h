//
//  PushService.h
//  SParking
//
//  Created by TXiMac on 2018/1/5.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushService : NSObject <XGPushDelegate>
+(instancetype)sharedService;

-(void)startWithLaunchOptions:(NSDictionary*)options;
@end
