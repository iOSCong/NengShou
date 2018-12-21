//
//  CarMarketTableViewCell.m
//  CarsStore
//
//  Created by Apple on 15-1-24.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarMarketTableViewCell.h"

@implementation CarMarketTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //类型
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        _typeLabel.backgroundColor = [UIColor colorWithRed:96/255.0 green:198/255.0 blue:56/255.0 alpha:1];
        _typeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_typeLabel];
//        [_typeLabel release];
        
        //简称
        self.shortNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 20)];
        [self addSubview:_shortNameLabel];
//        [_shortNameLabel release];
        
        //低价
        self.minPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 110, 20)];
        _minPriceLabel.textColor = [UIColor redColor];
        [self addSubview:_minPriceLabel];
//        [_minPriceLabel release];
        
        //高价
        self.guidePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 35, 90, 20)];
        _guidePriceLabel.textColor = [UIColor grayColor];
        _guidePriceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_guidePriceLabel];
//        [_minPriceLabel release];
        
        UIImageView *cuxiaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(mz_width-55, 0, 55, 50)];
        cuxiaoImage.image = [UIImage imageNamed:@"cuxiao.png"];
        [self addSubview:cuxiaoImage];
//        [cuxiaoImage release];
        
        //删除线
        UILabel *removeLine = [[UILabel alloc] initWithFrame:CGRectMake(140, 45, 60, 1)];
        removeLine.backgroundColor = [UIColor grayColor];
        [self addSubview:removeLine];
//        [removeLine release];
        
        //城市
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(mz_width-100, 35, 80, 20)];
        _cityNameLabel.alpha = 0.8;
        [self addSubview:_cityNameLabel];
//        [_cityNameLabel release];
        
        //地址图
        UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 65, 10, 18)];
        addressImageView.image = [UIImage imageNamed:@"ic_location.png"];
        [self addSubview:addressImageView];
//        [addressImageView release];
        
        //地址
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 55, mz_width-60, 40)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_addressLabel];
//        [_addressLabel release];
        
        //电话图
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 95, 15, 15)];
        phoneImageView.image = [UIImage imageNamed:@"ic_phone_2.png"];
        [self addSubview:phoneImageView];
//        [phoneImageView release];
        
        //电话
        self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 93, 240, 20)];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textColor = [UIColor blueColor];
        _phoneLabel.alpha = 0.7;
        [self addSubview:_phoneLabel];
//        [_phoneLabel release];
        
        //电话
        self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(45, 93, 100, 20);
        [self addSubview:_phoneBtn];
//        [_phoneBtn release];
        
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 119,self.bounds.size.width, 1)];
//        label.backgroundColor = [UIColor grayColor];
//        [self addSubview:label];
//        [label release];
        
    }
    return self;
}
- (void)setHotCars:(HotCars *)hotCars
{
    if (_hotCars != hotCars) {
//        _hotCars = [hotCars retain];
        self.typeLabel.text = _hotCars.type;
        self.shortNameLabel.text = _hotCars.shortName;
        self.minPriceLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minPrice floatValue]/10000.0]];
        self.guidePriceLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.guidePrice floatValue]/10000.0]];
        self.addressLabel.text = _hotCars.address;
        self.cityNameLabel.text = _hotCars.cityName;
        self.phoneLabel.text = _hotCars.phoneNumber;
    }
}






- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
