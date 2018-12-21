//
//  AllCarsTableViewCell.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllCars.h"
@interface AllCarsTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *titleLabel;  //名字
@property (nonatomic,retain)UIImageView *litpicLabel;  //图片
@property (nonatomic,retain)UILabel *countryLabel;  //国家
//@property (nonatomic,retain)UILabel *levelLabel;

@property (nonatomic,retain)AllCars *allCars;

@end
