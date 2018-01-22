//
//  HomeModelController.h
//  SParking
//
//  Created by Yazhao on 2018/1/15.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kHistorySearch;

@interface HomeModelController : NSObject

-(NSArray*)historySearches;

-(void)findParkAround:(CLLocationCoordinate2D)pt completion:(void (^)(NSArray *dataList, NSError *error))completion;

-(void)saveHistorySearch:(NSDictionary*)object;
@end
