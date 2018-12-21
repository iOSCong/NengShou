//
//  CarsIntroduceTableViewCell.h
//  CarsStore
//
//  Created by Apple on 15-1-21.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCars.h"

@interface CarsIntroduceTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *yearLabel;
@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UILabel *minGPLabel;
@property (nonatomic,retain)UILabel *maxGPLabel;
@property (nonatomic,retain)UILabel *shortLabel;
@property (nonatomic,retain)UILabel *removeLine;

@property (nonatomic,retain)HotCars *hotCars;

@end
