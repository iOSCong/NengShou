//
//  CarsDetailTableViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-21.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "FooterTabTableViewController.h"
#import "RequestData.h"
#import "HotCars.h"
#import "UIImageView+WebCache.h"
#import "CarsIntroduceTableViewCell.h"
#import "FooterCollectionViewController.h"
#import "CarMarketTableViewController.h"
#import "MBProgressHUD.h"

#define BYITAutoSize(dis) ((dis)*([[UIScreen mainScreen]bounds].size.width/320.0))

@interface FooterTabTableViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,RequestDataDelegate>

@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,retain)NSMutableArray *groupNameArr;
@property (nonatomic,retain)NSMutableDictionary *groupDic1;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIImageView *erwmImageView;

@property (nonatomic,retain)UIImageView *logoUrl;
@property (nonatomic,retain)UILabel *factoryName;
@property (nonatomic,retain)UILabel *serialName;
@property (nonatomic,retain)UILabel *maxPrice;
@property (nonatomic,retain)UILabel *minPrice;
@property (nonatomic,retain)UIView *backView;

@property (nonatomic,retain)MBProgressHUD *pHud;

@end

@implementation FooterTabTableViewController


#define logoKH 90

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"详细信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化一次
    self.groupNameArr = [NSMutableArray array];
    self.groupDic1 = [NSMutableDictionary dictionary];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    //    self.tableView.bounces = NO;
//    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [tableView registerClass:[CarsIntroduceTableViewCell class] forCellReuseIdentifier:@"aa"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    tableView.hidden = YES;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    //透明
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, logoKH)];
    clearView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    UIImageView *logoUrl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, logoKH+20, logoKH)];
    logoUrl.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    logoUrl.userInteractionEnabled = YES;
    [logoUrl sd_setImageWithURL:[NSURL URLWithString:self.logoUrlData] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    self.logoUrl = logoUrl;
    [clearView addSubview:logoUrl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [logoUrl addGestureRecognizer:tap];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [clearView addSubview:lineView];
    
    
    UILabel *factoryName = [[UILabel alloc] initWithFrame:CGRectMake(logoKH+30, 0, self.view.bounds.size.width-logoKH-40, 30)];
//    factoryName.backgroundColor = [UIColor blueColor];
    factoryName.text = [NSString stringWithFormat:@"品牌: %@",self.factoryNameData];
    factoryName.font = [UIFont systemFontOfSize:18];
    factoryName.textColor = [UIColor redColor];
    self.factoryName = factoryName;
    [clearView addSubview:factoryName];
    
    UILabel *serialName = [[UILabel alloc] initWithFrame:CGRectMake(logoKH+30, 30, self.view.bounds.size.width-logoKH-40, 30)];
//    serialName.backgroundColor = [UIColor greenColor];
    serialName.text = [NSString stringWithFormat:@"车  型: %@",self.serialNameData];
    serialName.font = [UIFont systemFontOfSize:14];
    self.serialName = serialName;
    [clearView addSubview:serialName];
    
    UILabel *maxPrice = [[UILabel alloc] initWithFrame:CGRectMake(logoKH+30, 60, (self.view.bounds.size.width-logoKH-40)/2, 20)];
//    maxPrice.backgroundColor = [UIColor greenColor];
    float maxPr = [self.maxPriceData floatValue];
    maxPrice.text = [NSString stringWithFormat:@"最高价: %.2f万",maxPr/10000.0];
    maxPrice.font = [UIFont systemFontOfSize:11];
    self.maxPrice = maxPrice;
    [clearView addSubview:maxPrice];
    
    UILabel *minPrice = [[UILabel alloc] initWithFrame:CGRectMake(logoKH+30+(self.view.bounds.size.width-logoKH-40)/2, 60, (self.view.bounds.size.width-logoKH-40)/2, 20)];
//    minPrice.backgroundColor = [UIColor greenColor];
    float minPr = [self.minPriceData floatValue];
    minPrice.text = [NSString stringWithFormat:@"最低价: %.2f万",minPr/10000.0];
    minPrice.font = [UIFont systemFontOfSize:11];
    self.minPrice = minPrice;
    [clearView addSubview:minPrice];
    
    self.tableView.tableHeaderView = clearView;
    
    //等待数据
    self.pHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.pHud.labelText = @"正在加载";
    
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-serial-price/get-car-category-price.htm" parameterDic:@{@"serialId":[NSString stringWithFormat:@"%@",self.serialId]} delegate:self];
}

- (void)tapHandle
{
    //点击出现大图
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:self.backView];
    
    self.erwmImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-BYITAutoSize(280))/2,self.view.bounds.size.height/2-BYITAutoSize(200/2),BYITAutoSize(280),BYITAutoSize(200))];
    self.erwmImageView.backgroundColor = [UIColor whiteColor];
    [self.erwmImageView sd_setImageWithURL:[NSURL URLWithString:self.logoUrlData] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    self.erwmImageView.userInteractionEnabled = YES;
    [self.backView addSubview:self.erwmImageView];
    
    //创建长按手势对象
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
    //长按手指个数
    longPress.numberOfTouchesRequired = 1; //默认为1;
    //设置长按时间,判定
    longPress.minimumPressDuration = 0.5; //默认为0.5;
    //设置长按时,允许移动的距离
    longPress.allowableMovement = 10; //默认为10;
    //给手势指定视图
    [self.erwmImageView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsHandle)];
    [self.backView addGestureRecognizer:dismiss];
    
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)longPressGesture
{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您是否要保存图片到系统相册?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertView show];
    }
}

//点击按钮，将self.imageView上面的image内容保存到本地相册，并指定判断保存成功与否的方法imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIImageWriteToSavedPhotosAlbum(self.erwmImageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

//实现imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"保存成功";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"保存失败";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}

- (void)tapsHandle
{
    [self.backView removeFromSuperview];
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
    self.tableView.hidden = NO;
    //重读数据,一定要写
    [self.tableView reloadData];
    [self.pHud hide:YES];
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
    myView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
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
    
    cell.backgroundColor = [UIColor whiteColor];
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
