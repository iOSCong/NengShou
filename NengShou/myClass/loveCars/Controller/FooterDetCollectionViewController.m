//
//  FooterCollectionViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-23.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "FooterDetCollectionViewController.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
#import "CarCollectionViewCell.h"
#import "FooterCarDetailTabViewController.h"
//#import "DXAlertView.h"
#import "FooterDetCollectionViewController.h"
#import "FooterTabTableViewController.h"
//#import "MBProgressHUD.h"

@interface FooterDetCollectionViewController () <RequestDataDelegate>

@property (nonatomic,retain)NSMutableArray *collectionArr;
@property (nonatomic,retain)UICollectionView *collect;
@property (nonatomic,retain)MBProgressHUD *pHud;

@end

@implementation FooterDetCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame hotCars:(HotCars *)hotCars
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
    // Do any additional setup after loading the view.
    self.title = @"媲美车型";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutCollectionView];
    //    self.collect.bounces = NO;
    self.collect.showsHorizontalScrollIndicator = NO;
    
    //等待数据
    self.pHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.pHud.labelText = @"正在加载";
    
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-basic/get-compete-car-serial.htm" parameterDic:@{@"serialId":[NSString stringWithFormat:@"%@",self.serialId]} delegate:self];
    
}

- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArray = [dataDic objectForKey:@"data"];
    for (NSDictionary *dic in dataArray) {
        HotCars *hotCars = [[HotCars alloc] init];
        [hotCars setValuesForKeysWithDictionary:dic];
        if (nil == self.collectionArr) {
            self.collectionArr = [NSMutableArray array];
        }
        [self.collectionArr addObject:hotCars];
//        [hotCars release];
    }
    //重读数据
    [self.collect reloadData];
    [self.pHud hide:YES];
}

- (void)layoutCollectionView
{
    //设置 cell
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置 cell item的大小
//    layout.itemSize = CGSizeMake(80, 80); //cell 的大小
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-40)/3, (self.view.bounds.size.width-40)/3);
    //设置item 左右最小距离
    layout.minimumInteritemSpacing = 10; //默认为10;
    //设置上下最小距离
    layout.minimumLineSpacing = 10; //默认为10;
    //设置 item 的范围
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); //cell上下左右之间的距离
    //设置滑动的方向
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //水平方向
    //创建UICollectionView对象
    self.collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
//    [layout release];
    //配置属性
    _collect.backgroundColor = [UIColor whiteColor];  //UICollectionView 的背景色
    //设置 DataSource 和 Deletegate
    _collect.dataSource = self;
    _collect.delegate = self;
    //注册cell
    [self.collect registerClass:[CarCollectionViewCell class] forCellWithReuseIdentifier:@"aa"];
    //添加到父视图
    [self.view addSubview:_collect];
//    [_collect release];
}

#pragma mark - DataSource  Delegate
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//设置每一个分区的item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionArr count];
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从重用队列中去取
    CarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aa" forIndexPath:indexPath];
    HotCars *hotCars = self.collectionArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hotCars.logoUrl] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    cell.textLabel.text = hotCars.serialName;
    return cell;
}
//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FooterTabTableViewController *carsDetailVC = [[FooterTabTableViewController alloc] init];
    HotCars *hotCars = self.collectionArr[indexPath.row];
    carsDetailVC.serialId = hotCars.serialId;
    carsDetailVC.logoUrlData = hotCars.logoUrl;
    carsDetailVC.factoryNameData = hotCars.factoryName;
    carsDetailVC.serialNameData = hotCars.serialName;
    carsDetailVC.maxPriceData = hotCars.maxPrice;
    carsDetailVC.minPriceData = hotCars.minPrice;
    [self.navigationController pushViewController:carsDetailVC animated:YES];
//    [carsDetailVC release];
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
