//
//  NSMutableDictionary+Extend.m
//  UParking
//
//  Created by 张亚召 on 2017/10/21.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import "NSMutableDictionary+Extend.h"

@implementation NSMutableDictionary(Extend)
-(void)removeEmptyObjects{
    for (id key in self.allKeys) {
        id value = [self objectForKey:key];
        if([value isEqual:NSNull.null] || [value isEqual:@"<null>"] || [value isEqual:@""]){
            [self setValue:nil forKey:key];
        }
    }
}
@end
