//
//  AllCarsDetailTableViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "AllCarsDetailTableViewController.h"
//#import "RequestData.h"
#import "HotCarsTableViewCell.h"
//#import "UIImageView+WebCache.h"
//#import "BrandStoryViewController.h"
#import "FooterCarDetailTabViewController.h"
//#import "MJRefresh.h"
//#import "MBProgressHUD.h"

#define ImageWidth [[UIScreen mainScreen] bounds].view.size.width
static CGFloat ImageHeight  = 160; //54*5-64;
//static CGFloat ImageWidth  = imageW;

@interface AllCarsDetailTableViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,retain)NSMutableArray *groupNameArr;
@property (nonatomic,retain)NSMutableDictionary *groupDic1;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)NSArray *listsArray;
@property (nonatomic,retain)MBProgressHUD *pHud;

@property (nonatomic,retain)UIImageView *imageV;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain) UIImageView *imgProfile;

@end

@implementation AllCarsDetailTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.allCars.name;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HotCarsTableViewCell class] forCellReuseIdentifier:@"aa"];
    
    [self requestData];
    
}

- (void)requestData
{
    NSString *url = @"http://price.cartype.kakamobi.com/api/open/car-type-basic/get-grouped-serial-list.htm";
    NSDictionary *params = @{@"brandId":[NSString stringWithFormat:@"%@",_allCars.id],@"type":@"0"};
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
    HttpRequest *httpRequest = [HttpRequest sharedInstance];
    [httpRequest GET:url params:params success:^(id responseObject) {
        //初始化一次
        self.groupNameArr = [NSMutableArray array];
        self.groupDic1 = [NSMutableDictionary dictionary];
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            NSString *title = [dic objectForKey:@"factoryName"];
            [_groupNameArr addObject:title];
            self.listsArray = [dic objectForKey:@"lists"];
            for (NSDictionary *dic1 in _listsArray) {
                HotCars *hotCars = [[HotCars alloc] init];
                [hotCars setValuesForKeysWithDictionary:dic1];
                if (nil == self.groupArr) {
                    self.groupArr = [NSMutableArray array];
                }
                [self.groupArr addObject:hotCars];
            }
            [_groupDic1 setObject:self.groupArr forKey:title];
            self.groupArr = [NSMutableArray array];
        }
        //重读数据,一定要写
        [self.tableView reloadData];
        
        [self requestDataSetting];
        
    } failure:nil];
}


#define BigTo 230  //放大的最大限度
#define Smoll 30  //缩小的最大限度

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset   = self.tableView.contentOffset.y;
    if (yOffset < 0) {
        CGFloat logoFac = ((ABS(yOffset)+90)*90)/90;
        if (logoFac < BigTo) {
            CGRect log = CGRectMake(-(logoFac-(self.view.bounds.size.width))/2, yOffset+20, logoFac, logoFac);
            self.imageV.frame = log;
        }else{
            CGRect log = CGRectMake(-(BigTo-(self.view.bounds.size.width))/2, yOffset+20, BigTo, BigTo);
            self.imageV.frame = log;
        }
    } else {
        CGFloat logoFac = -((ABS(yOffset)+90)*90)/90+180;
        if (logoFac > Smoll) {
            CGRect log = CGRectMake(-(logoFac-(self.view.bounds.size.width))/2, yOffset+20, logoFac, logoFac);
            self.imageV.frame = log;
        }else{
            CGRect log = CGRectMake(-(Smoll-(self.view.bounds.size.width))/2, yOffset+20, Smoll, Smoll);
            self.imageV.frame = log;
        }
    }
}

- (void)requestDataSetting
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    view.userInteractionEnabled = YES;
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 160);
    
    UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flowerRed"]]; //icon_logback.png
    backImgView.userInteractionEnabled = YES;
    backImgView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 160);
    [view addSubview:backImgView];
    
    //判断是否有数据
    if (self.listsArray == nil) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-40, self.view.bounds.size.height/2-40, 80, 80)];
        backImage.image = [UIImage imageNamed:@"sadFace.png"];
        [self.tableView addSubview:backImage];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+50, self.view.bounds.size.width, 30)];
        label.text = @"暂无数据";
        label.font = [UIFont systemFontOfSize:22];
        label.textAlignment = NSTextAlignmentCenter;
        [self.tableView addSubview:label];
    }
    
    //名字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, self.view.bounds.size.width, 25)];
    label.text = [NSString stringWithFormat:@"《%@》品牌简介",_allCars.name];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    [view addSubview:label];
    
    //log
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-90)/2, 20, 90, 90)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:_allCars.imgUrl]];
    self.imageV = imageV;
    [view addSubview:imageV];
    self.tableView.tableHeaderView = view;
    
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width, 20)];
    titleLabel.textColor=[UIColor redColor];
    titleLabel.text=[self.groupNameArr objectAtIndex:section];
    [myView addSubview:titleLabel];
    return myView;
}
//分区名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.groupNameArr[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    NSString * key = self.groupNameArr[indexPath.section];
    HotCars *hotCars = self.groupDic1[key][indexPath.row];
    cell.hotCars = hotCars;
    [cell.imgUrlLabel sd_setImageWithURL:[NSURL URLWithString:hotCars.imgUrl] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    cell.nameLabel.text = hotCars.name;
    cell.levelLabel.text = hotCars.level;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥ : %@ ~ %@万",[NSString stringWithFormat:@"%.2f",[hotCars.minPrice floatValue]/10000.0],[NSString stringWithFormat:@"%.2f",[hotCars.maxPrice floatValue]/10000.0]];
    if (nil == hotCars.minPrice && nil != hotCars.maxPrice) {
        cell.priceLabel.text = [NSString stringWithFormat:@"暂无数据 ~ ¥ : %@万",[NSString stringWithFormat:@"%.2f",[hotCars.maxPrice floatValue]/10000.0]];
    }
    if (nil == hotCars.maxPrice && nil != hotCars.minPrice){
        cell.priceLabel.text = [NSString stringWithFormat:@"¥ : %@万 ~ 暂无数据",[NSString stringWithFormat:@"%.2f",[hotCars.minPrice floatValue]/10000.0]];
    }
    if (nil == hotCars.minPrice && nil == hotCars.maxPrice){
        cell.priceLabel.text = @"暂无数据";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FooterCarDetailTabViewController *carsDetailVC = [[FooterCarDetailTabViewController alloc] init];
    NSString * key = self.groupNameArr[indexPath.section];
    HotCars *hotCars = self.groupDic1[key][indexPath.row];
    carsDetailVC.hotCars = hotCars;
    [self.navigationController pushViewController:carsDetailVC animated:YES];
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
