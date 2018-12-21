//
//  FooterDetViewController.h
//  CarsStore
//
//  Created by BYIT on 16/1/9.
//  Copyright © 2016年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCars.h"
#import "AllCars.h"

@interface FooterDetCollectionViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)HotCars *hotCars;
@property (nonatomic,copy)NSString *serialId;

-(id)initWithFrame:(CGRect)frame hotCars:(HotCars *)hotCars; //初始化方法

@end
