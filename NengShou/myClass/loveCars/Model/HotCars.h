//
//  HotCars.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCars : NSObject

@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *maxPrice;
@property (nonatomic,copy)NSString *minPrice;   //销售最低  全部起价
@property (nonatomic,copy)NSString *level;      //类型 如: 跑车
@property (nonatomic,retain)UIImage *image;

@property (nonatomic,copy)NSString *brandId;
@property (nonatomic,copy)NSString *coverImgUrl;

@property (nonatomic,copy)NSString *serialName;
@property (nonatomic,copy)NSString *serialId;  //另一个id

@property (nonatomic,copy)NSString *serialLogo;
@property (nonatomic,copy)NSString *logoUrl;
@property (nonatomic,copy)NSString *shortInfo;
@property (nonatomic,copy)NSString *factoryName;

//公有
@property (nonatomic,copy)NSString *minGuidePrice;   //全部 删除价 高
@property (nonatomic,copy)NSString *maxGuidePrice;

//全部  年份详情     销售最低价
@property (nonatomic,copy)NSString *year;
@property (nonatomic,copy)NSString *cartypeId;

//CarMarket
@property (nonatomic,copy)NSString *address;  //地址
@property (nonatomic,copy)NSString *cartypeName;  //Sportback 35 TFSI 进取型
@property (nonatomic,copy)NSString *cityName;  //城市名
@property (nonatomic,copy)NSString *dealerName;  //公司
@property (nonatomic,copy)NSString *guidePrice; //最高价199899.9999
@property (nonatomic,copy)NSString *phoneNumber;  //电话
@property (nonatomic,copy)NSString *shortName;  //简称
@property (nonatomic,copy)NSString *type;  //4s

@end
