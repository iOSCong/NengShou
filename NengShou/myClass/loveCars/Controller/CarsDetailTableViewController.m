//
//  CarsDetailTableViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-21.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarsDetailTableViewController.h"
#import "RequestData.h"
#import "HotCars.h"
#import "UIImageView+WebCache.h"
#import "CarsIntroduceTableViewCell.h"
#import "FooterCollectionViewController.h"
#import "CarMarketTableViewController.h"
#import "MBProgressHUD.h"

@interface CarsDetailTableViewController () <UITableViewDataSource,UITableViewDelegate,RequestDataDelegate>

@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,retain)NSMutableArray *groupNameArr;
@property (nonatomic,retain)NSMutableDictionary *groupDic1;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)MBProgressHUD *pHud;
@property (nonatomic,retain)UITableView *tableView;

@end

@implementation CarsDetailTableViewController

- (id)initWithFrame:(CGRect)frame hotCars:(HotCars *)hotCars
{
    self = [super init];
    if (self) {
        self.hotCars = hotCars;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     //初始化一次
     self.groupNameArr = [NSMutableArray array];
     self.groupDic1 = [NSMutableDictionary dictionary];
     
     UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
     tableView.backgroundColor = [UIColor clearColor];
     tableView.dataSource = self;
     tableView.delegate = self;
     
     //透明
     UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 190)];
     clearView.backgroundColor = [UIColor clearColor];
     tableView.tableHeaderView = clearView;
     
     
     //    self.tableView.bounces = NO;
     tableView.showsVerticalScrollIndicator = NO;
     [tableView registerClass:[CarsIntroduceTableViewCell class] forCellReuseIdentifier:@"aa"];
     //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView = tableView;
     [self.view addSubview:tableView];
//     [tableView release];
    
//    //透明
//    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 210)];
//    clearView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = clearView;
//    
//    self.view.backgroundColor = [UIColor clearColor];
////    self.tableView.bounces = NO;
//    self.tableView.showsVerticalScrollIndicator = NO;
//    [self.tableView registerClass:[CarsIntroduceTableViewCell class] forCellReuseIdentifier:@"aa"];
////    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //等待数据
//    self.pHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.pHud.labelText = @"正在加载";
    
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-serial-price/get-car-category-price.htm" parameterDic:@{@"serialId":[NSString stringWithFormat:@"%@",self.hotCars.id]} delegate:self];
    
    FooterCollectionViewController *carsDetailTVC = [[FooterCollectionViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80) hotCars:self.hotCars];
    [self addChildViewController:carsDetailTVC];
    carsDetailTVC.view.userInteractionEnabled = YES;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 80)];
    [view addSubview:carsDetailTVC.view];
    view.clipsToBounds = YES;     //clipsToBounds 截取屏幕能够显示的部分;
    self.tableView.tableFooterView = view;
//    [carsDetailTVC release];
//    [view release];
    
}

- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataD = [dataDic objectForKey:@"data"];
    NSArray *dataArray = [dataD objectForKey:@"saleCategory"];
    for (NSDictionary *dic in dataArray) {
        NSString *title = [dic objectForKey:@"name"];
        [_groupNameArr addObject:title];
        NSArray *cartypesArray = [dic objectForKey:@"cartypes"];
        for (NSDictionary *dic1 in cartypesArray) {
            HotCars *hotCars = [[HotCars alloc] init];
            [hotCars setValuesForKeysWithDictionary:dic1];
            if (nil == self.groupArr) {
                self.groupArr = [NSMutableArray array];
            }
            [self.groupArr addObject:hotCars];
//            [hotCars release];
        }
        [_groupDic1 setObject:self.groupArr forKey:title];
        self.groupArr = [NSMutableArray array];
    }
    //重读数据,一定要写
    [self.tableView reloadData];
//    [self.pHud hide:YES];
//    [self.imageView removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

//分区名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.groupNameArr[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width, 20)];
    titleLabel.textColor=[UIColor redColor];
    titleLabel.text=[self.groupNameArr objectAtIndex:section];
    [myView addSubview:titleLabel];
//    [titleLabel release];
    return myView;
//    [myView release];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarsIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    NSString * key = self.groupNameArr[indexPath.section];
    HotCars *hotCars = self.groupDic1[key][indexPath.row];
    cell.hotCars = hotCars;
    cell.yearLabel.text = [NSString stringWithFormat:@"%@款",hotCars.year];
    cell.nameLabel.text = hotCars.name;
    cell.minGPLabel.text = [NSString stringWithFormat:@"销售最低价 ¥ : %@万起",[NSString stringWithFormat:@"%.2f",[hotCars.minPrice floatValue]/10000.0]];
    
    if (hotCars.minPrice == nil) {
        cell.minGPLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[hotCars.minGuidePrice floatValue]/10000.0]];
    }
    
    cell.maxGPLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[hotCars.minGuidePrice floatValue]/10000.0]];
    cell.shortLabel.text = hotCars.shortInfo;
    
    if (hotCars.minPrice == nil) {
        [cell.maxGPLabel removeFromSuperview];
        [cell.removeLine removeFromSuperview];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CarMarketTableViewController *carMarketVC = [[CarMarketTableViewController alloc] init];
    NSString * key = self.groupNameArr[indexPath.section];
    HotCars *hotCars = self.groupDic1[key][indexPath.row];
    carMarketVC.hotCars = hotCars;
    [self.navigationController pushViewController:carMarketVC animated:YES];
//    [carMarketVC release];
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
