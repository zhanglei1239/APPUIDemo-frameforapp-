//
//  QuanziViewController.m
//  Volunteer
//
//  Created by zsl on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "QuanziViewController.h"

@interface QuanziViewController ()

@end

@implementation QuanziViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView * view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的圈子-我的日志 显示自己.png"]];
    [self.view addSubview:view];
     view.center = screenCenter;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
                                            
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
