//
//  NewsListTableViewCell.h
//  NengShou
//
//  Created by MCEJ on 2018/12/20.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
