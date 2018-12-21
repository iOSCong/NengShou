//
//  HotCarsTableViewCell.m
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "HotCarsTableViewCell.h"

@implementation HotCarsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        //图片
        self.imgUrlLabel = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 90, 70)];
        [self addSubview:_imgUrlLabel];
//        [_imgUrlLabel release];
        
        //名字
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 200, 45)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_nameLabel];
//        [_nameLabel release];
        
        //价位
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 45, 170, 20)];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = [UIColor grayColor];
        [self addSubview:_priceLabel];
//        [_priceLabel release];
        
        //类型
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-90, 5, 80, 45)];
        _levelLabel.font = [UIFont systemFontOfSize:12];
        _levelLabel.textAlignment = NSTextAlignmentRight;
        _levelLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_levelLabel];
//        [_levelLabel release];
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 79,self.bounds.size.width, 1)];
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
        self.nameLabel.text = _hotCars.name;
        self.levelLabel.text = _hotCars.level;
        self.priceLabel.text = [NSString stringWithFormat:@"¥ : %@ ~ %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minPrice floatValue]/10000.0],[NSString stringWithFormat:@"%.2f",[_hotCars.maxPrice floatValue]/10000.0]];
        if (nil == self.hotCars.minPrice && nil != self.hotCars.maxPrice) {
            self.priceLabel.text = [NSString stringWithFormat:@"暂无数据 ~ ¥ : %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.maxPrice floatValue]/10000.0]];
        }
        if (nil == self.hotCars.maxPrice && nil != self.hotCars.minPrice){
            self.priceLabel.text = [NSString stringWithFormat:@"¥ : %@万 ~ 暂无数据",[NSString stringWithFormat:@"%.2f",[_hotCars.minPrice floatValue]/10000.0]];
        }
        if (nil == self.hotCars.minPrice && nil == self.hotCars.maxPrice){
            self.priceLabel.text = @"暂无数据";
        }
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
