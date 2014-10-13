//
//  PersonSetingViewController.m
//  Volunteer
//
//  Created by zsl on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PersonSetingViewController.h"

@interface PersonSetingViewController ()

@end

@implementation PersonSetingViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"修改个人信息";
    UIImageView * view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"实名认证表单2.jpg"]];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 60, screenWidth, screenHeight-50);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, screenHeight-42, 320,40);
    [btn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
}
-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
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
