//
//  HeaderCollectionViewCell.h
//  CarsStore
//
//  Created by Apple on 15-1-23.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "AllCars.h"
@interface CarCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain)AllCars *allCars;

@property (nonatomic,retain)UIImageView *imageView; //cell上的图片视图
@property (nonatomic,retain)UILabel *textLabel; //文字视图

@end
