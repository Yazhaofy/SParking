//
//  PushService.m
//  SParking
//
//  Created by TXiMac on 2018/1/5.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "PushService.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define XG_SECRET_KEY @"3352d70fcfb0c75ee9c08a968ef95554"
#define XG_ACCESS_ID 2200274661
#define XG_ACCESS_KEY @"I73AI4S2XF3I"

@implementation PushService
static PushService *sharedService=nil;
+(instancetype)sharedService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService=[[self alloc]init];
    });
    return sharedService;
}
//启动推送服务并处理启动选项
-(void)startWithLaunchOptions:(NSDictionary *)options{
    [[XGPush defaultManager] setEnableDebug:YES];
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    
    XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];

    XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];

    [[XGPush defaultManager] setNotificationConfigure:configure];
    [[XGPush defaultManager] startXGWithAppID:XG_ACCESS_ID appKey:XG_ACCESS_KEY delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:options];
}

#pragma mark - XGPush delegate
-(void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error{
    NSLog(@"信鸽服务启动成功");
}
-(void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error{
    NSLog(@"信鸽服务已注销");
}

-(void)xgPushDidReportNotification:(BOOL)isSuccess error:(NSError *)error{
}

#pragma Mark - 新增API(IOS10)
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
-(void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
-(void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction003"]) {
        NSLog(@"click from Action3");
    }
    
    [[XGPush defaultManager] reportXGNotificationInfo:response.notification.request.content.userInfo];
    
    completionHandler();
}
#endif
@end
