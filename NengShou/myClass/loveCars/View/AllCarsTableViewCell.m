//
//  AllCarsTableViewCell.m
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "AllCarsTableViewCell.h"

@implementation AllCarsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //图标
        self.litpicLabel = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        [self addSubview:_litpicLabel];
        
        //名字
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 190, 30)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_titleLabel];
        
        //国家
        self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 100, 30)];
        _countryLabel.font = [UIFont systemFontOfSize:14];
        _countryLabel.textColor = [UIColor grayColor];
        [self addSubview:_countryLabel];
    }
    return self;
}
- (void)setAllCars:(AllCars *)allCars
{
    if (_allCars != allCars) {
//        _allCars = [allCars retain];
        self.titleLabel.text = _allCars.name;
        self.countryLabel.text = _allCars.country;
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
