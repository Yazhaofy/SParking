//
//  AppDelegate.m
//  SParking
//
//  Created by TXiMac on 2018/1/5.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "AppDelegate.h"
#import "PushService.h"
#import "LaunchGuideManager.h"
#import "MapManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window.backgroundColor=ThemeColor;
    
    //监控网络连接状况
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    //推送服务
    [PushService.sharedService startWithLaunchOptions:launchOptions];
    
    //地图服务
    [MapManager.defaultManager startMapService];
    
    //位置服务
    [LocationService.sharedService startUserLocationService];

    //启动引导
    [LaunchGuideManager.sharedManager setupLaunchIntroduction];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma Mark - 远程通知注册失败处理
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [NSNotificationCenter.defaultCenter postNotificationName:@"registerDeviceFailed" object:nil];
}

#pragma Mark - 远程通知处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"[XGDemo] receive Notification");
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
}

#pragma Mark - 静默通知处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    [XGPush.defaultManager reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


@end
