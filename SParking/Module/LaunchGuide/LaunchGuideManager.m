//
//  LaunchGuideManager.m
//  SParking
//
//  Created by Yazhao on 2018/1/8.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "LaunchGuideManager.h"
#import "LaunchIntroductionView.h"

@implementation LaunchGuideManager
static LaunchGuideManager *sharedManager=nil;
+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[[self alloc]init];
    });
    return sharedManager;
}

-(void)setupLaunchIntroduction{
    NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:3];
    for (int i=0; i<3; i++) {
        [imgArr addObject:[NSString stringWithFormat:@"guide%d_%.0fx%.0f",i,kScreen_width,kScreen_height]];
    }
    CGRect btnRect=CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45);
    
    [LaunchIntroductionView sharedWithStoryboard:@"Main" images:imgArr buttonImage:nil buttonFrame:btnRect];
}
@end
