//
//  AllCarsDetailTableViewController.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "HotCars.h"
#import "AllCars.h"
@interface AllCarsDetailTableViewController : BaseTableViewController

@property (nonatomic,retain)HotCars *hotCars;
@property (nonatomic,retain)AllCars *allCars;

@end
