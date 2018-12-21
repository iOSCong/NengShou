//
//  HotCarsTableViewCell.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCars.h"
@interface HotCarsTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UIImageView *imgUrlLabel;
@property (nonatomic,retain)UILabel *priceLabel;
@property (nonatomic,retain)UILabel *levelLabel;

@property (nonatomic,retain)HotCars *hotCars;

@end
