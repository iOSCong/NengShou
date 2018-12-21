//
//  NewsListViewController.m
//  NengShou
//
//  Created by MCEJ on 2018/12/20.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsListTableViewCell.h"
#import "WebUrlViewController.h"
#import "YMRefresh.h"

#define NEWS_IP @"http://v.juhe.cn"
#define newsKey @"bbbd6684c96ca7d14663691f0b0922f4"

@interface NewsListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) YMRefresh *refresh;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsListTableViewCell"];
    
    [self requestData];
    
    mzWeakSelf(self);
    _refresh = [[YMRefresh alloc] init];
    [_refresh gifModelRefresh:self.tableView refreshType:RefreshTypeDropDown firstRefresh:NO timeLabHidden:YES stateLabHidden:YES dropDownBlock:^{
        [self requestData];
        if ([weakself.tableView.mj_header isRefreshing]) {
            [weakself.tableView.mj_header endRefreshing];
        }
    } upDropBlock:^{}];
    
}

- (void)requestData
{
    NSString *url = NEWS_IP@"/toutiao/index";
    NSDictionary *params = @{@"type":@"top",@"key":newsKey};
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
    HttpRequest *httpRequest = [HttpRequest sharedInstance];
    [httpRequest GET:url params:params success:^(id responseObject) {
        self.tableView.hidden = NO;
        if ([responseObject[@"result"][@"stat"] integerValue] == 1) {
            NSArray *dataArr = responseObject[@"result"][@"data"];
            self.dataArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                [self.dataArr addObject:dic];
            }
            [self.tableView reloadData];
        }else{
            [MHProgressHUD showMsgWithoutView:responseObject[@"reason"]];
        }
    } failure:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListTableViewCell"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataArr[indexPath.row][@"thumbnail_pic_s"]]];
    [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"NoData"]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row][@"title"]];
    cell.typeLabel.text = [NSString stringWithFormat:@"  %@  ",self.dataArr[indexPath.row][@"author_name"]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row][@"date"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebUrlViewController *vc = [[WebUrlViewController alloc] init];
    vc.url = mzstring(self.dataArr[indexPath.row][@"url"]);
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
