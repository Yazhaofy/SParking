//
//  SearchController.h
//  SParking
//
//  Created by Yazhao on 2018/1/19.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchController : UISearchController
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSArray *parkingLots;
@end
