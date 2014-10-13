//
//  RegisterPageViewController.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "RegisterPageViewController.h"

@interface RegisterPageViewController ()<UITextFieldDelegate>

@end

@implementation RegisterPageViewController

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
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bgImg setImage:[UIImage imageNamed:@"findBg"]];
    [self.view addSubview:bgImg];
    
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [self.view addGestureRecognizer:oneFingerTwoTaps];
    self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(40, 140, 60, 30)];
    self.lblName.text = @"昵称:";
    [self.lblName setBackgroundColor:[UIColor clearColor]];
    self.lblName.textColor = [UIColor whiteColor];
    self.lblName.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.lblName];
    
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(120, 140, 160, 30)];
    [self.name setBackgroundColor:[UIColor clearColor]];
    self.name.delegate = self;
    self.name.placeholder = @"个人昵称";
    self.name.returnKeyType = UIReturnKeyNext;
    self.name.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.name];
    self.name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.nameLine = [[UIView alloc] initWithFrame:CGRectMake(40, 171, 240, 1)];
    [self.view addSubview:self.nameLine];
    [self.nameLine setBackgroundColor:[UIColor blackColor]];
    
    self.lblPwd = [[UILabel alloc] initWithFrame:CGRectMake(40, 172, 60, 30)];
    self.lblPwd.text = @"密码:";
    [self.lblPwd setBackgroundColor:[UIColor clearColor]];
    self.lblPwd.textColor = [UIColor whiteColor];
    self.lblPwd.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.lblPwd];
    
    
    self.pwd = [[UITextField alloc] initWithFrame:CGRectMake(120, 172, 160, 30)];
    [self.pwd setBackgroundColor:[UIColor clearColor]];
    self.pwd.delegate = self;
    self.pwd.placeholder = @"登陆密码";
    self.pwd.returnKeyType = UIReturnKeyNext;
    self.pwd.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.pwd];
    self.pwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.pwdLine = [[UIView alloc] initWithFrame:CGRectMake(40, 203, 240, 1)];
    [self.view addSubview:self.pwdLine];
    [self.pwdLine setBackgroundColor:[UIColor blackColor]];
    
    
    self.lblPhoneNum = [[UILabel alloc] initWithFrame:CGRectMake(40, 204, 60, 30)];
    self.lblPhoneNum.text = @"手机号:";
    [self.lblPhoneNum setBackgroundColor:[UIColor clearColor]];
    self.lblPhoneNum.textColor = [UIColor whiteColor];
    self.lblPhoneNum.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.lblPhoneNum];
    
    
    self.phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(120, 204, 120, 30)];
    [self.phoneNum setBackgroundColor:[UIColor clearColor]];
    self.phoneNum.placeholder = @"手机号码";
    self.phoneNum.delegate = self;
    self.phoneNum.returnKeyType = UIReturnKeyNext;
    self.phoneNum.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.phoneNum];
    self.phoneNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    self.phoneNumLine = [[UIView alloc] initWithFrame:CGRectMake(40, 235, 240, 1)];
    [self.view addSubview:self.phoneNumLine];
    [self.phoneNumLine setBackgroundColor:[UIColor blackColor]];
    
    self.lblMail = [[UILabel alloc] initWithFrame:CGRectMake(40, 236, 60, 30)];
    self.lblMail.text = @"邮箱号:";
    [self.lblMail setBackgroundColor:[UIColor clearColor]];
    self.lblMail.textColor = [UIColor whiteColor];
    self.lblMail.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:self.lblMail];
    
    
    self.mail = [[UITextField alloc] initWithFrame:CGRectMake(120, 236, 160, 30)];
    [self.mail setBackgroundColor:[UIColor clearColor]];
    self.mail.placeholder = @"邮箱号";
    self.mail.delegate = self;
    self.mail.returnKeyType = UIReturnKeyGo;
    self.mail.font = [UIFont fontWithName:@"Helvetica" size:18];
    self.mail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.mail];
    
    self.mailLine = [[UIView alloc] initWithFrame:CGRectMake(40, 266, 240, 1)];
    [self.view addSubview:self.mailLine];
    [self.mailLine setBackgroundColor:[UIColor blackColor]];
    
    self.btnGetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnGetPwd setBackgroundColor:[UIColor clearColor]];
    self.btnGetPwd.frame = CGRectMake(240, 204, 40, 30);
    [self.view addSubview:self.btnGetPwd];
    [self.btnGetPwd setTitle:@"获取" forState:UIControlStateNormal];
    self.btnGetPwd.layer.masksToBounds = YES;
    [self.btnGetPwd setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    self.btnGetPwd.layer.cornerRadius = 3;
    self.btnGetPwd.enabled = NO;
    self.btnGetPwd.hidden = YES;
    
    self.btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnConfirm setFrame:CGRectMake(50, 342, 100, 30)];
    self.btnConfirm.layer.masksToBounds = YES;
    self.btnConfirm.layer.cornerRadius = 6;
    [self.btnConfirm setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.view addSubview:self.btnConfirm];
    [self.btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    [self.btnConfirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCancel setFrame:CGRectMake(170, 342, 100, 30)];
    self.btnCancel.layer.masksToBounds = YES;
    self.btnCancel.layer.cornerRadius = 6;
    [self.btnCancel setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:self.btnCancel];
    [self.btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.isYanzheng = YES;
}

-(void)confirm{
    if (![self.name.text isEqualToString:@""]&&![self.pwd.text isEqualToString:@""]&&[Util isPhoneNum:self.phoneNum.text]&&[Util isMail:self.mail.text]) {
            if (![self isEmpty]) {
                [self.view endEditing:YES];
                if ([self.name.text isChinese]) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"用户名不支持中文"
                                          message:nil
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    return;
                }
                [self showHudInView:self.view hint:@"正在注册..."];
                [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.name.text
                                                                     password:self.pwd.text
                                                               withCompletion:
                 ^(NSString *username, NSString *password, EMError *error) {
                     [self hideHud];
                     
                     if (!error) {
                         TTAlertNoTitle(@"注册成功,请登录");
                         [self dismissViewControllerAnimated:YES completion:^{
                             
                         }];
                     }else{
                         switch (error.errorCode) {
                             case EMErrorServerNotReachable:
                                 TTAlertNoTitle(@"连接服务器失败!");
                                 break;
                             case EMErrorServerDuplicatedAccount:
                                 TTAlertNoTitle(@"您注册的用户已存在!");
                                 break;
                             case EMErrorServerTimeout:
                                 TTAlertNoTitle(@"连接服务器超时!");
                                 break;
                             default:
                                 TTAlertNoTitle(@"注册失败");
                                 break;
                         }
                     }
                 } onQueue:nil];
            }
    }else if([self.name.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if([self.pwd.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(![Util isPhoneNum:self.phoneNum.text]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确格式的电话号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(![Util isMail:self.mail.text]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确格式的邮箱账号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)hideKeyBoard{
    if (self.phoneNum.isFirstResponder) {
        self.isYanzheng = NO;
        [self.phoneNum resignFirstResponder];
    }else{
        [self textFieldShouldReturn:nil];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.name.isFirstResponder) {
        [self.name resignFirstResponder];
        [self.pwd becomeFirstResponder];
    }else if(self.pwd.isFirstResponder){
        [self.pwd resignFirstResponder];
        [self.phoneNum becomeFirstResponder];
        self.isYanzheng = YES;
    }else if(self.phoneNum.isFirstResponder){
        [self.phoneNum resignFirstResponder];
        [self.mail becomeFirstResponder];
    }else if(self.mail.isFirstResponder){
        [self.mail resignFirstResponder];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    BOOL result = YES;
    if (self.name.isFirstResponder) {
    }else if(self.pwd.isFirstResponder){
    }else if(self.phoneNum.isFirstResponder){
    }else{
    }
    
    return result;
}

-(BOOL)isPhoneNum:(NSString * )str{
    return [Util isPhoneNum:str];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.name.text;
    NSString *password = self.pwd.text;
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
