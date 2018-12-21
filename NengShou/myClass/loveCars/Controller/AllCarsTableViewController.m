//
//  AllCarsTableViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "AllCarsTableViewController.h"
#import "RequestData.h"
#import "AllCarsTableViewCell.h"
//#import "UIImageView+WebCache.h"  //图片下载
#import "AllCarsDetailTableViewController.h"
#import "HeaderCollectionViewController.h"
//#import "MBProgressHUD.h"

@interface AllCarsTableViewController () <UITableViewDelegate,UITableViewDataSource>

//分区及cell
@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,retain)NSMutableArray *groupNameArr;
@property (nonatomic,retain)NSMutableDictionary * groupDic1;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)MBProgressHUD *pHud;
@property (nonatomic,retain)NSUserDefaults * userD;

@end

@implementation AllCarsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.bounces = NO;
    [self.tableView registerClass:[AllCarsTableViewCell class] forCellReuseIdentifier:@"aa"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //改变索引的颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //改变索引选中的背景颜色
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    
    HeaderCollectionViewController *carsDetailTVC = [[HeaderCollectionViewController alloc] init];
    [self addChildViewController:carsDetailTVC];
    [self.tableView addSubview:carsDetailTVC.view];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = carsDetailTVC.view;
    
    [self requestData];
}

- (void)requestData
{
    NSString *url = @"http://price.cartype.kakamobi.com/api/open/car-type-basic/get-grouped-brand.htm";
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
    HttpRequest *httpRequest = [HttpRequest sharedInstance];
    [httpRequest GET:url params:nil success:^(id responseObject) {
        //初始化一次
        self.groupNameArr = [NSMutableArray array];
        self.groupDic1 = [NSMutableDictionary dictionary];
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            NSString *title = [dic objectForKey:@"firstLetter"];
            [_groupNameArr addObject:title];
            NSArray *listsArray = [dic objectForKey:@"lists"];
            for (NSDictionary *dic1 in listsArray) {
                AllCars *allCars = [[AllCars alloc] init];
                [allCars setValuesForKeysWithDictionary:dic1];
                if (nil == self.groupArr) {
                    self.groupArr = [NSMutableArray array];
                }
                [self.groupArr addObject:allCars];
            }
            [_groupDic1 setObject:self.groupArr forKey:title];
            self.groupArr = [NSMutableArray array];
        }
        //重读数据,一定要写
        [self.tableView reloadData];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } failure:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.groupNameArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.groupDic1[self.groupNameArr[section]] count];
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//设置 title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.groupNameArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 20)];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.text=[self.groupNameArr objectAtIndex:section];
    [myView addSubview:titleLabel];
    return myView;
}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.groupNameArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllCarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    NSString * key = self.groupNameArr[indexPath.section];
    AllCars *allCars = self.groupDic1[key][indexPath.row];
    cell.allCars = allCars;
    [cell.litpicLabel sd_setImageWithURL:[NSURL URLWithString:allCars.imgUrl] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    cell.titleLabel.text = allCars.name;
    cell.countryLabel.text = allCars.country;
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AllCarsDetailTableViewController *allCarsDetailVC = [[AllCarsDetailTableViewController alloc] init];
    NSString * key = self.groupNameArr[indexPath.section];
    AllCars *allCars = self.groupDic1[key][indexPath.row];
    allCarsDetailVC.allCars = allCars;
    [self.navigationController pushViewController:allCarsDetailVC animated:YES];
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
