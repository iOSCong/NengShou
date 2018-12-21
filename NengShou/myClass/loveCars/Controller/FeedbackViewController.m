//
//  FeedbackViewController.m
//  CarsStore
//
//  Created by BYIT on 16/1/10.
//  Copyright © 2016年 蓝欧科技. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBProgressHUD.h"

@interface FeedbackViewController () <UITextViewDelegate>

@property (nonatomic,retain)UITextView *textView;
@property (nonatomic,retain)MBProgressHUD *pHud;

@end

@implementation FeedbackViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //左边
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 20);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonHandle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    
    //右边
    UIButton *buttonRi = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRi.frame = CGRectMake(0, 0, 40, 20);
    [buttonRi setTitle:@"发送" forState:UIControlStateNormal];
    buttonRi.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonRi addTarget:self action:@selector(buttonRiHandle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnRi = [[UIBarButtonItem alloc] initWithCustomView:buttonRi];
    self.navigationItem.rightBarButtonItem = barBtnRi;
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width-20, 20)];
    label.text = @"欢迎您提出宝贵的意见.";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 94, self.view.bounds.size.width-20, 100)];
//    textView.backgroundColor = [UIColor greenColor];
    textView.returnKeyType =UIReturnKeyDone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    self.textView = textView;
    [self.view addSubview:textView];
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 200, self.view.bounds.size.width-10, 150)];
    imageV.backgroundColor = [UIColor orangeColor];
    imageV.image = [UIImage imageNamed:@"fourLove"];
    [self.view addSubview:imageV];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, self.view.bounds.size.width-20, 80)];
    textLabel.text = @"       当我们迈开步子去亲近世界,茉莉的芬芳是那样令人陶醉，微熏了一段无忧的年华，而红蜻蜓，仿佛一个清晰的节点，在记忆的荷尖上停驻，无论你从任何时空闯入，都能被它引向童年的盛夏.";
    textLabel.textColor = [UIColor purpleColor];
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    textLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textLabel];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder]; //［要实现的方法］
        [self buttonRiHandle];
        return NO;
    }
    return YES;
}

- (void)sendInformation
{
    
}

- (void)buttonHandle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonRiHandle
{
    [self.textView resignFirstResponder];
    
    MBProgressHUD *p = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    p.mode = MBProgressHUDModeText;
    p.labelText = @"发送成功";
    [p hide:YES afterDelay:1];
    
    [self performSelector:@selector(dismissHandle) withObject:self afterDelay:1.5];
}

- (void)dismissHandle
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
