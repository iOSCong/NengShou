//
//  CarsIntroduceTableViewCell.m
//  CarsStore
//
//  Created by Apple on 15-1-21.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarsIntroduceTableViewCell.h"
//#import "CarPriceLineLabel.h"

@implementation CarsIntroduceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //年份 2013
        self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
        _yearLabel.textColor = [UIColor blackColor];
        _yearLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_yearLabel];
//        [_yearLabel release];
        
        //名字 6.0L S
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 230, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_nameLabel];
//        [_nameLabel release];
        
        //价格低
        self.minGPLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 190, 20)];
        _minGPLabel.font = [UIFont systemFontOfSize:15];
        _minGPLabel.textColor = [UIColor blackColor];
        _minGPLabel.alpha = 0.8;
        [self addSubview:_minGPLabel];
//        [_minGPLabel release];
        
        //价格高
        self.maxGPLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 30, 100, 20)];
        _maxGPLabel.font = [UIFont systemFontOfSize:14];
        _maxGPLabel.textColor = [UIColor grayColor];
        [self addSubview:_maxGPLabel];
//        [_maxGPLabel release];
        
        //删除线
        self.removeLine = [[UILabel alloc] initWithFrame:CGRectMake(205, 40, 70, 1)];
        _removeLine.backgroundColor = [UIColor grayColor];
        [self addSubview:_removeLine];
//        [_removeLine release];
        
        //档位
        self.shortLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, self.bounds.size.width-20, 20)];
        _shortLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_shortLabel];
//        [_shortLabel release];
        
        //风格线
//        UILabel *lineStyle = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, self.bounds.size.width, 1)];
//        lineStyle.backgroundColor = [UIColor grayColor];
//        [self addSubview:lineStyle];
//        [lineStyle release];
        
    }
    return self;
}
- (void)setHotCars:(HotCars *)hotCars
{
    if (_hotCars != hotCars) {
//        _hotCars = [hotCars retain];
        self.yearLabel.text = [NSString stringWithFormat:@"%@款",_hotCars.year];
        self.nameLabel.text = _hotCars.name;
        self.minGPLabel.text = [NSString stringWithFormat:@"销售最低价 ¥ : %@万起",[NSString stringWithFormat:@"%.2f",[_hotCars.minPrice floatValue]/10000.0]];
        
        if (_hotCars.minPrice == nil) {
            self.minGPLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minGuidePrice floatValue]/10000.0]];
        }
        
        self.maxGPLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minGuidePrice floatValue]/10000.0]];
        self.shortLabel.text = _hotCars.shortInfo;
        
        if (_hotCars.minPrice == nil) {
            [self.maxGPLabel removeFromSuperview];
            [self.removeLine removeFromSuperview];
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
