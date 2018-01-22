//
//  NetworkManager.h
//  SParking
//
//  Created by Yazhao on 2018/1/15.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkResponse)(NSDictionary *info,NSError *error);

@interface NetworkManager : NSObject
+(instancetype)manager;

@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSDictionary *params;
@property(nonatomic,copy)NetworkResponse response;
@property(nonatomic,strong)NSString *method;

-(void)startRequest;
@end
