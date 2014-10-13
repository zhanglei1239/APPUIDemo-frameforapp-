//
//  IntroductoryPageViewController.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "IntroductoryPageViewController.h"
#import "LoadingPageViewController.h"
@interface IntroductoryPageViewController ()

@end

@implementation IntroductoryPageViewController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self setData];
    [self setUpView];
}
-(void)setData{
    self.data = [NSMutableArray arrayWithCapacity:3];
    NSString * img1 = @"introductory_1";
    NSString * img2 = @"introductory_2";
    NSString * img3 = @"introductory_3";
    [self.data addObject:img1];
    [self.data addObject:img2];
    [self.data addObject:img3];
}

-(void)setUpView{
    int count = 0;
    for (NSString * imgName in self.data) {
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(count*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [view setImage:[UIImage imageNamed:imgName]];
        [self.scrollView addSubview:view];
        [self.scrollView setContentSize:CGSizeMake((count+1)*ScreenWidth, ScreenHeight)];
        if (count == [self.data count]-1) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor clearColor]];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 6;
            [self.scrollView addSubview:btn];
            btn.frame = CGRectMake(0, ScreenHeight-100, 140, 30);
            btn.center = CGPointMake((count)*ScreenWidth+ScreenWidth/2, ScreenHeight-86);
            [btn addTarget:self action:@selector(loadIn) forControlEvents:UIControlEventTouchUpInside];
        }
        count++;
    }
}

-(void)loadIn{
    [self presentViewController:[[LoadingPageViewController alloc] init] animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
}

@end
