//
//  CarMarketTableViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-24.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "CarMarketTableViewController.h"
#import "CarMarketTableViewCell.h"
#import "RequestData.h"
#import "MJRefresh.h"
#import "FooterCollectionViewController.h"
//#import "DXAlertView.h"
#import "MBProgressHUD.h"

@interface CarMarketTableViewController () <UITableViewDataSource,UITableViewDelegate,RequestDataDelegate,UIAlertViewDelegate>
{
    UIWebView *phoneCallWebView;
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,assign)int page;  //页数
@property (nonatomic,retain)NSArray *dataArray;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)MBProgressHUD *pHud;

@end

@implementation CarMarketTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"销售信息";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self myCircle];
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[CarMarketTableViewCell class] forCellReuseIdentifier:@"aa"];
    [self.view addSubview:self.tableView];
    
    
    //等待数据
    self.pHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.pHud.labelText = @"正在加载";
    
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-price/get-car-type-price-list.htm" parameterDic:@{@"cartypeId":[NSString stringWithFormat:@"%@",self.hotCars.cartypeId],@"limit":@"10",@"orderField":@"2",@"orderType":@"1"} delegate:self];
//
//    //下拉刷新
//    [self.tableView addHeaderWithCallback:^{
//        self.groupArr = nil;
//        [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-price/get-car-type-price-list.htm" parameterDic:@{@"cartypeId":[NSString stringWithFormat:@"%@",self.hotCars.cartypeId],@"limit":@"10",@"orderField":@"2",@"orderType":@"1"} delegate:self];
//        [self.tableView headerEndRefreshing];
//        _page = 2;
//    }];
//
//    //上拉加载
//    [self.tableView addFooterWithCallback:^{
//        [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-price/get-car-type-price-list.htm" parameterDic:@{@"cartypeId":[NSString stringWithFormat:@"%@",self.hotCars.cartypeId],@"limit":@"10",@"orderField":@"2",@"orderType":@"1",@"page":[NSString stringWithFormat:@"%d",_page]} delegate:self];
//        [self.tableView footerEndRefreshing];
//        _page++;
//    }];
//    _page = 2;
//
}
////自定义转圈加载数据
//- (void)myCircle
//{
//    //创建对象
//    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.tiff"]];
//    self.imageView.frame = CGRectMake(self.view.bounds.size.width/2-70, self.view.bounds.size.height/2-70, 70, 70);
//    //设置位置
//    _imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-40);
//    //创建一个图片数组
//    NSMutableArray *picArr = [NSMutableArray array];
//    for (int i = 1; i <= 20; i++) {
//        //创建image对象
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.tiff",i]];
//        //添加到数组
//        [picArr addObject:image];
//    }
//    //将图片数组设置为动画图片组
//    _imageView.animationImages = picArr;
//    //改变速度
//    _imageView.animationDuration = 0.7;
//    //开始动画
//    [_imageView startAnimating];
//    [self.view addSubview:_imageView];
//    [_imageView release];
//}

- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.dataArray = [dataDic objectForKey:@"data"];
    if (self.dataArray != nil) {
        for (NSDictionary *dic in _dataArray) {
            HotCars *hotCars = [[HotCars alloc] init];
            [hotCars setValuesForKeysWithDictionary:dic];
            if (nil == self.groupArr) {
                self.groupArr = [NSMutableArray array];
            }
            [self.groupArr addObject:hotCars];
//            [hotCars release];
        }
        self.tableView.hidden = NO;
        //重读数据,一定要写
        [self.tableView reloadData];
        [self.pHud hide:YES];
    }
    
    if (self.dataArray.count == 0 && _page == 2) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-40, self.view.bounds.size.height/2-40, 80, 80)];
        backImage.image = [UIImage imageNamed:@"sadFace.png"];
        [self.view addSubview:backImage];
//        [backImage release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+50, self.view.bounds.size.width, 30)];
        label.text = @"暂无数据";
        label.font = [UIFont systemFontOfSize:22];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
//        [label release];
        
        self.tableView.bounces = NO;
        
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
//    [view release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    imageView.image = [UIImage imageNamed:@"detailholder.png"];
    [view addSubview:imageView];
//    [imageView release];
    
    UIView *viewName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25)];
    viewName.backgroundColor = [UIColor blackColor];
    viewName.alpha = 0.5;
    [view addSubview:viewName];
//    [viewName release];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, 25)];
    nameLabel.text = [NSString stringWithFormat:@"%@款   %@",_hotCars.year,_hotCars.name];
    nameLabel.textColor = [UIColor redColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    [view addSubview:nameLabel];
//    [nameLabel release];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width-10, 20)];
    typeLabel.text = [NSString stringWithFormat:@"厂商指导价 ¥: %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minGuidePrice floatValue]/10000.0]];
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:typeLabel];
//    [typeLabel release];
    
    UILabel *shouLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width-10, 20)];
    shouLabel.text = [NSString stringWithFormat:@"销售最低价 ¥: %@万",[NSString stringWithFormat:@"%.2f",[_hotCars.minPrice floatValue]/10000.0]];
    shouLabel.textColor = [UIColor whiteColor];
    shouLabel.textAlignment = NSTextAlignmentLeft;
    shouLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:shouLabel];
//    [shouLabel release];
    //如果销售最低价为空,移除此控件
    if (_hotCars.minPrice == nil) {
        [shouLabel removeFromSuperview];
    }
    
    self.tableView.tableHeaderView = view;
    
    //转圈视图移除
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupArr count];
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HotCars *hotCars = self.groupArr[indexPath.row];
    cell.hotCars = hotCars;
    
    cell.typeLabel.text = hotCars.type;
    cell.shortNameLabel.text = hotCars.shortName;
    cell.minPriceLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[hotCars.minPrice floatValue]/10000.0]];
    cell.guidePriceLabel.text = [NSString stringWithFormat:@"¥ : %@万",[NSString stringWithFormat:@"%.2f",[hotCars.guidePrice floatValue]/10000.0]];
    cell.addressLabel.text = hotCars.address;
    cell.cityNameLabel.text = hotCars.cityName;
    cell.phoneLabel.text = hotCars.phoneNumber;
    
    cell.phoneBtn.tag = indexPath.row;
    [cell.phoneBtn addTarget:self action:@selector(phoneBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)phoneBtnHandle:(UIButton *)button
{
    HotCars *hotCars = self.groupArr[button.tag];
    [self dialPhoneNumber:hotCars.phoneNumber];
}

- (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",aPhoneNumber]];
    
    if ( !phoneCallWebView ) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [self.view addSubview:phoneCallWebView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
