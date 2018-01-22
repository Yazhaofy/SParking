//
//  UIColor+Extend.m
//  SParking
//
//  Created by Yazhao on 2018/1/12.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "UIColor+Extend.h"

@implementation UIColor(Extend)
+(UIColor *)colorWithRGBHex:(UInt32)hex{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
+(UIColor*)colorWithHexString:(NSString *)string{
    if ([string hasPrefix:@"#"])
    {
        string = [string substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
    return [UIColor colorWithRGBHex:hexNum];
}
@end
