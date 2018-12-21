//
//  AllCars.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllCars : NSObject

@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *level;   //类型  如: 跑车

@property (nonatomic,retain)UIImage *image;

@end
