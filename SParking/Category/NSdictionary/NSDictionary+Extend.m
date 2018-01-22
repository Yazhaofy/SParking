//
//  NSDictionary+Extend.m
//  UParking
//
//  Created by 张亚召 on 2017/10/21.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import "NSDictionary+Extend.h"

@implementation NSDictionary(Extend)
-(NSString*)toUrlParamString{
    NSMutableString *tmpStr=[[NSMutableString alloc]init];
    for (NSString *key in self.allKeys) {
        id value=self[key];
        NSString *param=[NSString stringWithFormat:@"%@=%@&",key,value];
        [tmpStr appendString:param];
    }
    [tmpStr deleteCharactersInRange:NSMakeRange(tmpStr.length-1, 1)];
    return tmpStr;
}
@end
