//
//  NSString+Extend.h
//  UParking
//
//  Created by 张亚召 on 2017/10/21.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Extend)
-(BOOL)isUrlString;
-(instancetype)urlStringWithParams:(NSDictionary*)params;
@end
