//
//  NewsListTableViewCell.m
//  NengShou
//
//  Created by MCEJ on 2018/12/20.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.typeLabel.layer.borderWidth = 0.5f;
    self.typeLabel.layer.borderColor = mz_color(20, 150, 255).CGColor;
    self.typeLabel.layer.cornerRadius = 8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
