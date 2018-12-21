//
//  CarMarketTableViewCell.h
//  CarsStore
//
//  Created by Apple on 15-1-24.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCars.h"
@interface CarMarketTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *typeLabel;
@property (nonatomic,retain)UILabel *shortNameLabel;
@property (nonatomic,retain)UILabel *minPriceLabel;
@property (nonatomic,retain)UILabel *guidePriceLabel;  //高价
@property (nonatomic,retain)UILabel *cityNameLabel;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UIButton *phoneBtn;

@property (nonatomic,retain)HotCars *hotCars;

@end
