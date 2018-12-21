//
//  HeaderCollectionViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-22.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "HeaderCollectionViewController.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
#import "CarCollectionViewCell.h"
#import "FooterCarDetailTabViewController.h"

@interface HeaderCollectionViewController () <RequestDataDelegate>

@property (nonatomic,retain)NSMutableArray *collectionArr;
@property (nonatomic,retain) UICollectionView *collect;

@end

@implementation HeaderCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    [self layoutCollectionView];
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-basic/get-hot-serial-list.htm" parameterDic:nil delegate:self];
}

- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArray = [dataDic objectForKey:@"data"];
    for (NSDictionary *dic in dataArray) {
        AllCars *allCars = [[AllCars alloc] init];
        [allCars setValuesForKeysWithDictionary:dic];
        if (nil == self.collectionArr) {
            self.collectionArr = [NSMutableArray array];
        }
        [self.collectionArr addObject:allCars];
    }
    //重读数据
    [self.collect reloadData];
}

- (void)layoutCollectionView
{
    //设置 cell
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置 cell item的大小
    layout.itemSize = CGSizeMake(80, 80); //cell 的大小
    //设置item 左右最小距离
    layout.minimumInteritemSpacing = 0; //默认为10;
    //设置上下最小距离
    layout.minimumLineSpacing = 0; //默认为10;
    //设置 item 的范围
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0); //cell上下左右之间的距离
    //设置滑动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //水平方向
    //创建UICollectionView对象
    self.collect = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //配置属性
    _collect.backgroundColor = [UIColor whiteColor];  //UICollectionView 的背景色
    //设置 DataSource 和 Deletegate
    _collect.dataSource = self;
    _collect.delegate = self;
    
//    _collect.bounces = NO;
    _collect.showsHorizontalScrollIndicator = NO;
    
    //注册cell
    [self.collect registerClass:[CarCollectionViewCell class] forCellWithReuseIdentifier:@"aa"];
    //添加到父视图
    [self.view addSubview:_collect];
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
    AllCars *allCars = self.collectionArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:allCars.imgUrl] placeholderImage:[UIImage imageNamed:@"img_02.png"]];
    cell.textLabel.text = allCars.name;
    return cell;
}
//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FooterCarDetailTabViewController *carsDetailVC = [[FooterCarDetailTabViewController alloc] init];
    AllCars *allCars = self.collectionArr[indexPath.row];
    carsDetailVC.hotCars = allCars;
    NSLog(@"===%@=",carsDetailVC.hotCars.id);
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
