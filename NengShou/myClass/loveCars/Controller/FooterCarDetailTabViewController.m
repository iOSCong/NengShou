//
//  CarsDetailViewController.m
//  CarsStore
//
//  Created by Apple on 15-1-21.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "FooterCarDetailTabViewController.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
#import "CarsDetailTableViewController.h"
#import "FooterCollectionViewController.h"
#import "MBProgressHUD.h"
#import "CarMarketTableViewController.h"

//static CGFloat ImageHeight  = 210;

@interface FooterCarDetailTabViewController () <RequestDataDelegate>

@property (nonatomic,retain)NSMutableArray *groupArr;
@property (nonatomic,retain)MBProgressHUD *pHud;
@property (nonatomic,retain)UIImageView *imageV;
//@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)CarsDetailTableViewController *carsDetailTVC;

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView *sheetView;
@property (nonatomic,assign)BOOL isOne;

@property (nonatomic,retain)UIImageView *erwmImageView;

@end

@implementation FooterCarDetailTabViewController

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
    
    self.navigationItem.title = self.hotCars.name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isOne = YES;
    
    //等待数据
    self.pHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    self.pHud.labelText = @"正在加载";
    
    [[RequestData alloc] initWithURLString:@"http://price.cartype.kakamobi.com/api/open/car-type-basic/get-serial-base-info.htm" parameterDic:@{@"serialId":[NSString stringWithFormat:@"%@",self.hotCars.id]} delegate:self];
    
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(0, 0, 20, 20);
    [downBtn setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(barItemHandle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:downBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    
    
//    CarsDetailTableViewController *carsDetailTVC = [[CarsDetailTableViewController alloc] initWithFrame:CGRectMake(0, 290, self.view.bounds.size.width, self.view.bounds.size.height-290) hotCars:self.hotCars];
//    carsDetailTVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-160+36+190);
//    carsDetailTVC.view.backgroundColor = [UIColor whiteColor];
//    [self addChildViewController:carsDetailTVC];
//    [self.view addSubview:carsDetailTVC.tableView];
//    [carsDetailTVC release];
    
}

- (void)barItemHandle
{
    if (_isOne == YES) {
        [self layoutSheetView];
        _isOne = NO;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.sheetView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
        }];
        [self.backView removeFromSuperview];
        _isOne = YES;
    }
}

//自定义 actionSheet
- (void)layoutSheetView
{
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    self.backView = backView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barItemHandle)];
    [self.backView addGestureRecognizer:tap];
    
    
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)];
    sheetView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.sheetView = sheetView;
    [self.view addSubview:sheetView];
    
    [UIView animateWithDuration:0.3 animations:^{
        sheetView.frame = CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 100);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, 5, self.view.bounds.size.width, 40);
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [sheetView addSubview:sureBtn];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 55, self.view.bounds.size.width, 40);
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [sheetView addSubview:cancelBtn];
    
}

- (void)sureBtnHandle
{
    [self cancelBtnHandle];
    //保存图片
    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)cancelBtnHandle
{
    [UIView animateWithDuration:0.3 animations:^{
        self.sheetView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    }];
    [self.backView removeFromSuperview];
    _isOne = YES;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (_isOne == YES) {
//        [self layoutSheetView];
//        _isOne = NO;
//    }else{
//        [UIView animateWithDuration:0.3 animations:^{
//            self.sheetView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
//        }];
//        [self.backView removeFromSuperview];
//        _isOne = YES;
//    }
//}

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


- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataD = [dataDic objectForKey:@"data"];
    HotCars *hotCars = [[HotCars alloc] init];
    [hotCars setValuesForKeysWithDictionary:dataD];
    if (nil == self.groupArr) {
        self.groupArr = [NSMutableArray array];
    }
    [self.groupArr addObject:hotCars];
//    [hotCars release];
    
    //背景色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 210)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
//    [backView release];
    
    //大图
    UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 210)];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:hotCars.coverImgUrl] placeholderImage:[UIImage imageNamed:@"carback_image.png"]];
    self.imageV = coverImageView;
    [backView addSubview:coverImageView];
//    [coverImageView release];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [coverImageView addSubview:view];
//    [view release];
    
    //车标
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64, 40, 40)];
    [logImageView sd_setImageWithURL:[NSURL URLWithString:hotCars.logoUrl]];
    [self.view addSubview:logImageView];
//    [logImageView release];
    
    UILabel *serialNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 68, 200, 15)];
    serialNameLabel.text = hotCars.serialName;
    serialNameLabel.textColor = [UIColor redColor];
    serialNameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:serialNameLabel];
//    [serialNameLabel release];
    
    UILabel *shortInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 85, 250, 15)];
    shortInfoLabel.text = hotCars.shortInfo;
    shortInfoLabel.textColor = [UIColor whiteColor];
    shortInfoLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:shortInfoLabel];
//    [shortInfoLabel release];
    
    //厂商指导价透明条
    UIView *viewm = [[UIView alloc] initWithFrame:CGRectMake(0, 190, self.view.bounds.size.width, 20)];
    viewm.backgroundColor = [UIColor blackColor];
    viewm.alpha = 0.2;
    [coverImageView addSubview:viewm];
//    [viewm release];
    
    //厂商指导价
    UILabel *guidePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 254, self.view.bounds.size.width-5, 20)];
    guidePriceLabel.text = [NSString stringWithFormat:@"厂商指导价 ¥ : %@ ~ %@万",[NSString stringWithFormat:@"%.2f",[hotCars.minGuidePrice floatValue]/10000.0],[NSString stringWithFormat:@"%.2f",[hotCars.maxGuidePrice floatValue]/10000.0]];
    guidePriceLabel.textColor = [UIColor redColor];
    guidePriceLabel.textAlignment = NSTextAlignmentRight;
    guidePriceLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:guidePriceLabel];
//    [guidePriceLabel release];
    
    
//    FooterCollectionViewController *carsCollTVC = [[FooterCollectionViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80) hotCars:self.hotCars];
//    [self addChildViewController:carsCollTVC];
//    carsCollTVC.view.userInteractionEnabled = YES;
//    UIView * viewColl = [[UIView alloc]initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, 80)];
//    [viewColl addSubview:carsCollTVC.view];
//    viewColl.clipsToBounds = YES;     //clipsToBounds 截取屏幕能够显示的部分;
////    self.tableView.tableFooterView = view;
//    [self.view addSubview:viewColl];
//    [carsCollTVC release];
//    [viewColl release];
    
    
//    CarsDetailTableViewController *carsDetailTVC = [[CarsDetailTableViewController alloc] initWithFrame:CGRectMake(0, 290, self.view.bounds.size.width, self.view.bounds.size.height-290) hotCars:self.hotCars];
//    carsDetailTVC.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-160+36+190-64);
//    carsDetailTVC.view.backgroundColor = [UIColor clearColor];
//    [self addChildViewController:carsDetailTVC];
//    //(2)设置行高
//    carsDetailTVC.tableView.rowHeight = 80;
//    carsDetailTVC.tableView.delegate = self;
//    self.carsDetailTVC = carsDetailTVC;
//    [self.view addSubview:carsDetailTVC.tableView];
//    [carsDetailTVC release];
    
    
    CarsDetailTableViewController *carsDetailTVC = [[CarsDetailTableViewController alloc] initWithFrame:CGRectMake(0, 290, self.view.bounds.size.width, self.view.bounds.size.height-290) hotCars:self.hotCars];
    carsDetailTVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:carsDetailTVC];
    [self.view addSubview:carsDetailTVC.view];
//    [carsDetailTVC release];
    
    
    [self.pHud hide:YES];
    
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
