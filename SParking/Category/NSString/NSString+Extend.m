//
//  NSString+Extend.m
//  UParking
//
//  Created by 张亚召 on 2017/10/21.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString(Extend)
-(BOOL)isUrlString{
    if(!self) return NO;
    
    NSString *tmpUrl=nil;
    if([self hasPrefix:@"www."]){
        tmpUrl = [NSString stringWithFormat:@"http://%@",self];
    }else{
        tmpUrl=self;
    }
 
    NSString *urlRegex = @"(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:tmpUrl];
}
-(instancetype)urlStringWithParams:(NSDictionary *)params{
    NSMutableString *paramStr=[[NSMutableString alloc]init];
    for (NSString *key in params.allKeys) {
        NSString *param=[NSString stringWithFormat:@"%@=%@&",key,params[key]];
        [paramStr appendString:param];
    }
    [paramStr deleteCharactersInRange:NSMakeRange(paramStr.length-1, 1)];
    
    if(paramStr.length>0){
        return [NSString stringWithFormat:@"%@?%@",self,paramStr];
    }

    return self;
}
@end
