//
//  FindBackByMailViewController.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "FindBackByMailViewController.h"

@interface FindBackByMailViewController ()

@end

@implementation FindBackByMailViewController

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
    int height = 0;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
        height = 0;
    }else{
        height = -20;
    }
    
    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bgImg setImage:[UIImage imageNamed:@"findBg"]];
    // Do any additional setup after loading the view.
    
    //第一步：
    self.step1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.step1];
    [self.step1 addSubview:bgImg];
    
    self.lblPleaseInputAccount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.lblPleaseInputAccount.text = @"请输入账号:";
    self.lblPleaseInputAccount.backgroundColor = [UIColor clearColor];
    [self.lblPleaseInputAccount setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    self.lblPleaseInputAccount.center = CGPointMake(ScreenCenter.x-50, ScreenCenter.y-60);
    [self.lblPleaseInputAccount setTextColor:[UIColor whiteColor]];
    [self.step1 addSubview:self.lblPleaseInputAccount];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [self.step1 addSubview:view];
    [view.layer setBorderColor:[UIColor grayColor].CGColor];
    [view.layer setBorderWidth:2];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.center = CGPointMake(ScreenCenter.x, ScreenCenter.y-30);
    
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 190, 30)];
    [self.step1 addSubview:self.account];
    [self.account setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [self.account setValue:[UIFont boldSystemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    self.account.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.account.center = CGPointMake(ScreenCenter.x, ScreenCenter.y-30);
    self.account.placeholder = @"用户账号";
    
    self.btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNext.frame = CGRectMake(0, 0, 200, 30);
    [self.step1 addSubview:self.btnNext];
    [self.btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [self.btnNext setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.btnNext.layer setMasksToBounds:YES];
    [self.btnNext.layer setCornerRadius:4];
    self.btnNext.center = CGPointMake(ScreenCenter.x, ScreenCenter.y+20);
    [self.btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBack.frame =CGRectMake(0, ScreenHeight-40+height, 60, 40);
    [self.step1 addSubview:self.btnBack];
    [self.btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.btnBack setTitle:@" 返回" forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(backToLoad) forControlEvents:UIControlEventTouchUpInside];
    
    //第二步：
    self.step2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UIImageView * bgImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bgImg1 setImage:[UIImage imageNamed:@"findBg"]];
    [self.step2 addSubview:bgImg1];
    [self.view addSubview:self.step2];
    self.step2.hidden = YES;
    
    self.lblUserPhoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    self.lblUserPhoneTitle.text = @"您注册的邮箱是:";
    [self.lblUserPhoneTitle setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    self.lblUserPhoneTitle.center = CGPointMake(ScreenCenter.x-20, ScreenCenter.y-100);
    [self.lblUserPhoneTitle setTextColor:[UIColor whiteColor]];
    [self.step2 addSubview:self.lblUserPhoneTitle];
    self.lblUserPhoneTitle.backgroundColor = [UIColor clearColor];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [self.step2 addSubview:view1];
    [view1.layer setBorderColor:[UIColor grayColor].CGColor];
    [view1.layer setBorderWidth:2];
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 4;
    view1.center = CGPointMake(ScreenCenter.x, ScreenCenter.y-70);
    
    self.lblUserPhone = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [self.step2 addSubview:self.lblUserPhone];
    self.lblUserPhone.center = CGPointMake(ScreenCenter.x, ScreenCenter.y-70);
    self.lblUserPhone.text = @" zhangleixxxx@xxx.com";
    self.lblUserPhone.backgroundColor = [UIColor clearColor];
    
    self.btnGetMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnGetMessage.frame = CGRectMake(0, 0, 80, 30);
    [self.step2 addSubview:self.btnGetMessage];
    [self.btnGetMessage.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.btnGetMessage setTitle:@"获取验证邮件" forState:UIControlStateNormal];
    [self.btnGetMessage setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.btnGetMessage.layer setMasksToBounds:YES];
    [self.btnGetMessage.layer setCornerRadius:4];
    self.btnGetMessage.center = CGPointMake(ScreenCenter.x+50, ScreenCenter.y-20);
    [self.btnGetMessage addTarget:self action:@selector(getMsg) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnLast = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLast.frame = CGRectMake(0, 0, 80, 30);
    [self.step2 addSubview:self.btnLast];
    [self.btnLast setTitle:@"上一步" forState:UIControlStateNormal];
    [self.btnLast setBackgroundColor:[UIColor colorWithRed:0 green:101/255.0 blue:123/255.0 alpha:1]];
    [self.btnLast.layer setMasksToBounds:YES];
    [self.btnLast.layer setCornerRadius:4];
    [self.btnLast.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    self.btnLast.center = CGPointMake(ScreenCenter.x-50, ScreenCenter.y-20);
    [self.btnLast addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:oneFingerTwoTaps];
}
-(void)hideKeyBoard{
    if (self.account.isFirstResponder) {
        [self.account resignFirstResponder];
    } 
}
-(void)backToLoad{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)next{
    //TODO 获取对应的账号注册的手机号
    [self hideKeyBoard];
    self.step1.hidden = YES;
    self.step2.hidden = NO;
}

-(void)last{
    self.step1.hidden = NO;
    self.step2.hidden = YES;
}

-(void)confirm{
    //TODO 验证短信验证码是否正确之后跳转到修改密码页面
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)getMsg{
    //TODO 获取短信验证码
    [self performSelector:@selector(confirm) withObject:nil afterDelay:.3];
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
