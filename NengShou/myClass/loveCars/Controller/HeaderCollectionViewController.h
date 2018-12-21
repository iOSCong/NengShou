//
//  HeaderCollectionViewController.h
//  CarsStore
//
//  Created by Apple on 15-1-22.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AllCars.h"
@interface HeaderCollectionViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)AllCars *allCars;

@end
