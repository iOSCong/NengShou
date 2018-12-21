//
//  DetailViewController.h
//  NengShou
//
//  Created by MCEJ on 2018/12/18.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *queryBtn;


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *content1;
@property (weak, nonatomic) IBOutlet UILabel *content2;
@property (weak, nonatomic) IBOutlet UILabel *content3;

@property (nonatomic,assign)int type;

@end
