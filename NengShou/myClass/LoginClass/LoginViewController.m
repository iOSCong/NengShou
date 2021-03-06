//
//  LoginViewController.m
//  HZMHIOS
//
//  Created by MCEJ on 2017/12/27.
//  Copyright © 2017年 MCEJ. All rights reserved.
//

#import "LoginViewController.h"
#import "WSLoginView.h"
#import "HomeViewController.h"
#import "MHNavViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

//- (void)loginNotice
//{
//    [MHProgressHUD showMsgWithoutView:@"登录失败,账号或密码已失效!"];
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [AVAnalytics beginLogPageView:@"LoginView"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [AVAnalytics endLogPageView:@"LoginView"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotice)name:@"login" object:nil];
    
    WSLoginView *wsLoginV = [[WSLoginView alloc]initWithFrame:CGRectMake(0, 0, mz_width, mz_height)];
    wsLoginV.titleLabel.text = @"能手";
    wsLoginV.titleLabel.textColor = [UIColor grayColor];
    wsLoginV.hideEyesType = LeftEyeHide;
    [self.view addSubview:wsLoginV];
    
    //登录
    [wsLoginV setClickLoginBlock:^(NSString *textField1Text, NSString *textField2Text) {
        if (![textField1Text isEqualToString:@""] && ![textField2Text isEqualToString:@""]) {
            [MHProgressHUD showProgress:@"正在登录" inView:self.view];
            [AVUser logInWithUsernameInBackground:textField1Text password:textField2Text block:^(AVUser *user, NSError *error){
                [MHProgressHUD hide];
                NSLog(@"user===%@",user);
                if (user) {
                    //存储账户密码
                    [NSStrObject saveAccount:textField1Text];
                    [NSStrObject savePassword:textField2Text];
                    
                    HomeViewController *home = [[HomeViewController alloc] init];
                    MHNavViewController *nav = [[MHNavViewController alloc] initWithRootViewController:home];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                } else {
                    NSLog(@"登录失败：%@",error.localizedFailureReason);
                    [MHProgressHUD showMsgWithoutView:@"登录失败"];
                }
            }];
        }else{
            [MHProgressHUD showMsgWithoutView:@"请输入正确的账号或密码"];
        }
    }];
    
    //注册
    [wsLoginV setClickLostBlock:^(NSString *textField1Text, NSString *textField2Text) {
        if (![textField1Text isEqualToString:@""] && ![textField2Text isEqualToString:@""]) {
            [MHProgressHUD showProgress:@"正在注册" inView:self.view];
            AVUser *user = [AVUser user];
            user.username = textField1Text;
            user.password = textField2Text;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // 注册成功直接登录
                    [AVUser logInWithUsernameInBackground:user.username password:user.password block:^(AVUser *user, NSError *error){
                        [MHProgressHUD hide];
                        if (user) {
                            HomeViewController *home = [[HomeViewController alloc] init];
                            MHNavViewController *nav = [[MHNavViewController alloc] initWithRootViewController:home];
                            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                        } else {
                            NSLog(@"登录失败：%@",error.localizedFailureReason);
                            [MHProgressHUD showMsgWithoutView:@"登录失败"];
                        }
                    }];
                }else if(error.code == 202){
                    //注册失败的原因可能有多种，常见的是用户名已经存在。
                    NSLog(@"注册失败，用户名已经存在");
                    [MHProgressHUD showMsgWithoutView:@"注册失败，用户名已经存在"];
                }else{
                    NSLog(@"注册失败：%@",error.localizedFailureReason);
                    [MHProgressHUD showMsgWithoutView:@"注册失败"];
                }
            }];
        }else{
            [MHProgressHUD showMsgWithoutView:@"请输入账号和密码"];
        }

    }];
    
}

-(void)dealloc
{
    //移除了所有的通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除了名称为tongzhi的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
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
