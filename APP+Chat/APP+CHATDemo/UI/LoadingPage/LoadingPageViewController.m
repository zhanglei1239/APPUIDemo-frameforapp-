//
//  LoadingPageViewController.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "LoadingPageViewController.h"
#import "FindBackByPhoneViewController.h"
#import "FindBackByMailViewController.h"
#import "RegisterPageViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "AppDelegate.h"
@interface LoadingPageViewController ()

@end

@implementation LoadingPageViewController

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
    
    int height = 0;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
        height = 0;
    }else{
        height = -20;
    }
    
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [self.view addGestureRecognizer:oneFingerTwoTaps];
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bgImg setImage:[UIImage imageNamed:@"loadingPageBg"]];
    [self.view addSubview:bgImg];
    
    //输入用户名相关行
    self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 222, 18, 18)];
    [self.userImg setImage:[UIImage imageNamed:@"account.png"]];
    [self.view addSubview:self.userImg];
    
    self.userText = [[UITextField alloc] initWithFrame:CGRectMake(80, 216, 192, 30)];
    [self.userText setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.userText];
    self.userText.placeholder = @"邮箱号/手机号";
    self.userText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(50, 246, 222, 1)];
    [self.lineView1 setBackgroundColor:[UIColor grayColor]];
    self.lineView1.alpha = .5;
    [self.view addSubview:self.lineView1];
    
    //输入密码相关行
    self.pwdImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 260, 18, 18)];
    [self.pwdImg setImage:[UIImage imageNamed:@"password.png"]];
    [self.view addSubview:self.pwdImg];
    
    self.pwdText = [[UITextField alloc] initWithFrame:CGRectMake(80, 254, 192, 30)];
    [self.pwdText setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.pwdText];
    self.pwdText.placeholder = @"密码";
    self.pwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 284, 222, 1)];
    [self.lineView2 setBackgroundColor:[UIColor grayColor]];
    self.lineView2.alpha = .5;
    [self.view addSubview:self.lineView2];
    
    
    //登陆按钮
    self.btnLog = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLog.frame = CGRectMake((ScreenWidth-228)/2, 320, 228, 42);
    [self.btnLog setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.btnLog setTitle:@"登陆" forState:UIControlStateNormal];
    self.btnLog.layer.masksToBounds = YES;
    self.btnLog.layer.cornerRadius = 6;
    [self.view addSubview:self.btnLog];
    [self.btnLog addTarget:self action:@selector(loadIn) forControlEvents:UIControlEventTouchUpInside];
    
    //找回按钮
    self.btnFindBack = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnFindBack.frame = CGRectMake(10, ScreenHeight-40+height, 100, 40);
    [self.btnFindBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFindBack setTitle:@"无法登陆?" forState:UIControlStateNormal];
    [self.view addSubview:self.btnFindBack];
    [self.btnFindBack.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.btnFindBack addTarget:self action:@selector(findBack:) forControlEvents:UIControlEventTouchUpInside];
    
    //注册按钮
    self.btnRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRegist.frame = CGRectMake(ScreenWidth-80, ScreenHeight-40+height, 80, 40);
    [self.btnRegist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnRegist setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:self.btnRegist];
    [self.btnRegist.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.btnRegist addTarget:self action:@selector(registUser) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupForFindBack];
}
-(void)setupForFindBack{
    
    self.findBack = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 100)];
    [self.findBack setBackgroundColor:[UIColor clearColor]];
    self.findBack.layer.masksToBounds = YES;
    self.findBack.layer.cornerRadius = 6;
    UIButton * findByMail = [UIButton buttonWithType:UIButtonTypeCustom];
    [findByMail setBackgroundColor:[UIColor whiteColor]];
    findByMail.frame = CGRectMake(0, 0, self.findBack.frame.size.width, 50);
    [findByMail setTitle:@"邮件找回" forState:UIControlStateNormal];
    [findByMail setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [findByMail.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.findBack addSubview:findByMail];
    [findByMail addTarget:self action:@selector(findByMail) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * findByPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [findByPhone setBackgroundColor:[UIColor whiteColor]];
    findByPhone.frame = CGRectMake(0, 50, self.findBack.frame.size.width, 50);
    [findByPhone setTitle:@"手机找回" forState:UIControlStateNormal];
    [findByPhone setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [findByPhone.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.findBack addSubview:findByPhone];
    [findByPhone addTarget:self action:@selector(findByPhone) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.findBack];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 51, self.findBack.frame.size.width, 1)];
    [view setBackgroundColor:[UIColor grayColor]];
    [self.findBack addSubview:view];
}

//邮件找回密码
-(void)findByMail{
    //TODO 邮箱找回密码功能接入
    [UIView animateWithDuration:.1 animations:^{
        self.findBack.center =CGPointMake(ScreenWidth/2,ScreenHeight+50);
    } ];
    [self presentViewController:[[FindBackByMailViewController alloc] init] animated:YES completion:^{
        
    }];
}

//手机找回密码
-(void)findByPhone{
    //TODO 手机短信找回密码功能接入
    [UIView animateWithDuration:.1 animations:^{
        self.findBack.center =CGPointMake(ScreenWidth/2,ScreenHeight+50);
    } ];
    [self presentViewController:[[FindBackByPhoneViewController alloc] init] animated:YES completion:^{
        
    }];
}

-(void)loadIn{
    [self doLogin:nil];
}

//找回密码
-(void)findBack:(id)sender{
    //TODO 找回密码功能
    [UIView animateWithDuration:.2 animations:^{
        self.findBack.center =CGPointMake(ScreenWidth/2,ScreenHeight-50);
    } ];
   
}

-(void)registUser{
   //TODO 注册用户
    [self presentViewController:[[RegisterPageViewController alloc] init] animated:YES completion:nil];
}

-(void)hideKeyBoard{
    [UIView animateWithDuration:.2 animations:^{
        self.findBack.center =CGPointMake(ScreenWidth/2,ScreenHeight+50);
    } ];
    [self textFieldShouldReturn:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.userText.isFirstResponder) {
        [self.userText resignFirstResponder];
    }else{
        [self.pwdText resignFirstResponder];
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doRegister:(id)sender {
    
}
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:@"正在登录..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (loginInfo && !error) {
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
         }else {
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(@"连接服务器失败!");
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(@"用户名或密码错误");
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(@"连接服务器超时!");
                     break;
                 default:
                     TTAlertNoTitle(@"登录失败");
                     break;
             }
         }
     } onQueue:nil];
}
- (IBAction)doLogin:(id)sender {
    if (![self isEmpty]) {
        [self.view endEditing:YES];
        if ([self.userText.text isChinese]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"用户名不支持中文"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }
#if !TARGET_IPHONE_SIMULATOR
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"填写推送消息时使用的昵称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *nameTextField = [alert textFieldAtIndex:0];
        nameTextField.text = self.usernameTextField.text;
        [alert show];
#elif TARGET_IPHONE_SIMULATOR
        [self loginWithUsername:self.userText.text password:self.pwdText.text];
#endif
    }
}


- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.userText.text;
    NSString *password = self.pwdText.text;
    if (username.length == 0 || password.length == 0) {
        ret = YES;
        [WCAlertView showAlertWithTitle:@"提示"
                                message:@"请输入账号和密码"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
    }
    
    return ret;
}

@end
