//
//  DetailViewController.m
//  NengShou
//
//  Created by MCEJ on 2018/12/18.
//  Copyright © 2018年 MCEJ. All rights reserved.
//

#import "DetailViewController.h"

#define JUHE_IP @"http://apis.juhe.cn"
#define POST_IP @"http://v.juhe.cn"
#define QQ_IP @"http://japi.juhe.cn"

#define postKey @"b25f2eef6863c5a4f8686f9f6d4406c0"
#define mobileKey @"64ac7b9ff13aa0cafa34b956cafdf97a"
#define idCardKey @"8aa020ada8d14c8552c2cdc97ff2540f"
#define ipKey @"85e9ec1d90b1d145c84a40660808320a"
#define historyKey @"428f58955225d4289412e79ad3bb0a9b"

@interface DetailViewController () <UITextFieldDelegate>

@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *textStr;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"便民查询";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textStr = @"";
    
    mzWeakSelf(self);
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.textField addAction:^(UITextField *textField) {
        weakself.textStr = textField.text;
    }];
    
    //查询
    [self.queryBtn addTarget:^(UIButton *button) {
        if (mzisequal(self.textStr, @"")) {
            [MHProgressHUD showMsgWithoutView:@"请输入查询内容"];
            return ;
        }
        [weakself requestData];
    }];
}

- (void)requestData
{
    NSString *url = @"";
    NSDictionary *params = @{};
    if (self.type == 7) {
        url = POST_IP@"/postcode/query";
        params = @{@"postcode":self.textStr,@"key":postKey};
    }else if (self.type == 9) {
        url = JUHE_IP@"/mobile/get";
        params = @{@"phone":self.textStr,@"key":mobileKey};
    }else if (self.type == 10) {
        url = JUHE_IP@"/idcard/index";
        params = @{@"cardno":self.textStr,@"key":idCardKey};
    }else if (self.type == 11) {
        url = JUHE_IP@"/ip/ip2addr";
        params = @{@"ip":self.textStr,@"key":ipKey};
    }
    [MHProgressHUD showProgress:@"加载中..." inView:self.view];
    HttpRequest *httpRequest = [HttpRequest sharedInstance];
    [httpRequest GET:url params:params success:^(id responseObject) {
        if (self.type == 7) {
            if ([responseObject[@"result"][@"list"] count]) {
                NSDictionary *dic = responseObject[@"result"][@"list"][0];
                self.title1.text = @"省市区:";
                self.content1.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"Province"],dic[@"City"],dic[@"District"]];
                self.title2.text = @"地址:";
                self.content2.text = mz_NSNString(dic[@"Address"]);
            }else{
                [MHProgressHUD showMsgWithoutView:@"查询失败,请检查输入内容是否正确"];
            }
        }else{
            if (mzisequal(responseObject[@"resultcode"], @"200")) {
                if (self.type == 9) {
                    self.title1.text = @"运营商:";
                    self.content1.text = mz_NSNString(responseObject[@"result"][@"company"]);
                    self.title2.text = @"归属地:";
                    self.content2.text = [NSString stringWithFormat:@"%@ %@",responseObject[@"result"][@"province"],responseObject[@"result"][@"city"]];
                    self.title3.text = @"区号:";
                    self.content3.text = mz_NSNString(responseObject[@"result"][@"areacode"]);
                }else if (self.type == 10) {
                    self.title1.text = @"地址:";
                    self.content1.text = mz_NSNString(responseObject[@"result"][@"area"]);
                    self.title2.text = @"性别:";
                    self.content2.text = mz_NSNString(responseObject[@"result"][@"sex"]);
                    self.title3.text = @"出生日期:";
                    self.content3.text = mz_NSNString(responseObject[@"result"][@"birthday"]);
                }else if (self.type == 11) {
                    self.title1.text = @"区域:";
                    self.content1.text = mz_NSNString(responseObject[@"result"][@"area"]);
                    self.title2.text = @"类型:";
                    self.content2.text = mz_NSNString(responseObject[@"result"][@"location"]);
                }
            }else{
                [MHProgressHUD showMsgWithoutView:@"查询失败,请检查输入内容是否正确"];
            }
        }
    } failure:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
