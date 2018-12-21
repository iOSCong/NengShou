//
//  FooterTabTableViewController.h
//  CarsStore
//
//  Created by BYIT on 16/1/9.
//  Copyright © 2016年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCars.h"
@interface FooterTabTableViewController : UIViewController

@property (nonatomic,retain)HotCars *hotCars;

//-(id)initWithFrame:(CGRect)frame hotCars:(HotCars *)hotCars; //初始化方法

@property (nonatomic,copy)NSString *serialId;

@property (nonatomic,copy)NSString *logoUrlData;
@property (nonatomic,copy)NSString *factoryNameData;
@property (nonatomic,copy)NSString *serialNameData;
@property (nonatomic,copy)NSString *maxPriceData;
@property (nonatomic,copy)NSString *minPriceData;

@end
