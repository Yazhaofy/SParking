//
//  SearchResultCell.h
//  uPaParking
//
//  Created by 张亚召 on 2017/10/17.
//  Copyright © 2017年 张亚召. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
