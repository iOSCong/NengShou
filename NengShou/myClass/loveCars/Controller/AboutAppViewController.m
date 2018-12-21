//
//  AboutAppViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-27.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "AboutAppViewController.h"
#import "FeedbackViewController.h"
//#import "BackView.h"

@interface AboutAppViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSUserDefaults * userD;

@end

@implementation AboutAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define appAbout_WH 100

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
//    [tableView release];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height -160-64)];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-appAbout_WH/2, headerView.frame.size.height/2-appAbout_WH/2-30, appAbout_WH, appAbout_WH)];
    backImage.image = [UIImage imageNamed:@"appAbout"];
    [headerView addSubview:backImage];
//    [backImage release];
    
    
    
//    代码实现获得应用的Verison号：
//    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//    或
    NSString *verison = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
//    获得build号：
//    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    
    UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backImage.frame.origin.y + appAbout_WH, self.view.bounds.size.width, 30)];
//    alabel.backgroundColor = [UIColor greenColor];
    alabel.text = [NSString stringWithFormat:@"Verison: %@",verison];
    alabel.textColor = [UIColor grayColor];
    alabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:alabel];
//    [alabel release];
    
    
//    headerView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = headerView;
//    [headerView release];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerView;
    
    
    UILabel *blabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 10, 300, 20)];
    blabel.text = @"Copyright @ 2015-12-26 MJGZM";
    blabel.textColor = [UIColor grayColor];
    blabel.font = [UIFont systemFontOfSize:14];
    blabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:blabel];
//    [blabel release];
    
    
    UILabel *clabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 30, 300, 20)];
    clabel.text = @"All Rights Reserved";
    clabel.textColor = [UIColor grayColor];
    clabel.font = [UIFont systemFontOfSize:14];
    clabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:clabel];
//    [clabel release];
    
}

- (void)xxxxx
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-280)/2, 110, 280, 170)];
    imageView.image = [UIImage imageNamed:@"about_App.png"];
    [self.view addSubview:imageView];
//    [imageView release];
    
    UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, self.view.bounds.size.height-178, 300, 30)];
    alabel.text = @"爱车大全 iOS版 V1.0";
    alabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alabel];
//    [alabel release];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aa"];
    }
    cell.textLabel.text = @"";
    
    UISwitch *mySwith = (UISwitch *)[cell viewWithTag:202];
    if (mySwith == nil) {
        mySwith = [[UISwitch alloc] initWithFrame:CGRectMake(cell.bounds.size.width-60, 35/2-20/2-2, 50, 20)];
        [mySwith addTarget:self action:@selector(mySwithHandle:) forControlEvents:UIControlEventValueChanged];
        mySwith.hidden = YES;
        mySwith.tag = indexPath.row;
        [cell addSubview:mySwith];
    }
    
    if ([self.tagStr isEqualToString:@"1"]) {
        mySwith.on = YES;
    }else if ([self.tagStr isEqualToString:@"2"]) {
        mySwith.on = NO;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"夜间模式";
        cell.imageView.image = [UIImage imageNamed:@"night"];
        mySwith.hidden = NO;
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"用户反馈";
        cell.imageView.image = [UIImage imageNamed:@"silder_user"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //无事件触发
    }else if (indexPath.row == 1){
        FeedbackViewController *allCarsDetailVC = [[FeedbackViewController alloc] init];
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:allCarsDetailVC];
        //设置模态风格
        navigationVC.modalPresentationStyle = UIModalPresentationFullScreen; //满屏
        navigationVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //进行模态
        [self.navigationController presentViewController:navigationVC animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)layoutBackImageView
{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backImage.image = [UIImage imageNamed:@"tableViewBack"];
    [self.view addSubview:backImage];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
