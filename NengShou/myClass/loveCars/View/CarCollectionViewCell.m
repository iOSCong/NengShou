//
//  HeaderCollectionViewCell.m
//  CarsStore
//
//  Created by Apple on 15-1-23.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarCollectionViewCell.h"

@implementation CarCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //图片视图
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width, self.frame.size.height/4*3)];
        [self addSubview:_imageView];
        
        //文字视图
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4*3-5+3, self.frame.size.width, self.frame.size.height/4)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_textLabel];
        
        //风格线
//        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, self.bounds.size.width, 1)];
//        lineLabel.backgroundColor = [UIColor grayColor];
//        [self addSubview:lineLabel];
//        [lineLabel release];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
