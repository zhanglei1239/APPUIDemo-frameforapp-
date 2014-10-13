//
//  LeftViewController.m
//  Volunteer
//
//  Created by zsl on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LeftViewController.h"
//#import "SetingViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MainViewController.h"
//#import "QuanziViewController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

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
//    self.view.backgroundColor=[UIColor greenColor];
//    UIImageView * backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, screenHeight)];
//    backImage.image=[UIImage imageNamed:@"qqqq.jpg"];
//    [self.view addSubview:backImage];
//    
//    titleArr=[NSArray arrayWithObjects:@"我的信息",@"我的日志",@"我的圈子",@"我的成长历程",@"我的活动",@"我的组织",@"时间银行", nil];
//    listView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 250, screenHeight-60) style:UITableViewStyleGrouped];
//    listView.backgroundColor=[UIColor clearColor];
//    listView.delegate=self;
//    listView.dataSource=self;
//    [self.view addSubview:listView];
//    
//    imageArr=[NSArray arrayWithObjects:@"日志.png",@"日志.png",@"圈子.png",@"成长历程.png",@"参与活动.png",@"参与组织.png",@"时间银行.png",nil];
//    UIButton * setButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    setButton.frame=CGRectMake(20, screenHeight-50, 65, 30);
//    //[setButton setBackgroundColor:[UIColor redColor]];
//    [setButton addTarget:self action:@selector(setButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:setButton];
//    
//    UIImageView * setImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 25, 25)];
//    //setImage.backgroundColor=[UIColor redColor];
//    setImage.image=[UIImage imageNamed:@"设置.png"];
//    [setButton addSubview:setImage];
//    
//    UILabel * setLb=[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 30, 20)];
//    setLb.text=@"设置";
//    //setLb.backgroundColor=[UIColor yellowColor];
//    setLb.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
//    [setButton addSubview:setLb];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * backView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    
//    UIImageView * topImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 40, 70, 70)];
//    topImage.image=[UIImage imageNamed:@"2012100413195471481.jpg"];
//    topImage.layer.masksToBounds=YES;
//    topImage.layer.cornerRadius=35;
//    [backView addSubview:topImage];
//    
//    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake(110, 45, 100, 20)];
//    name.text=@"赵信";
//    name.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
//    name.textColor=[UIColor whiteColor];
//    [backView addSubview:name];
//    
//    UIImageView * dengjiImage=[[UIImageView alloc]initWithFrame:CGRectMake(100, 75, 125, 25)];
//    //dengjiImage.backgroundColor=[UIColor redColor];
//    dengjiImage.image=[UIImage imageNamed:@"等级.png"];
//    [backView addSubview:dengjiImage];
//    
//    UIImageView * huizhangImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 170, 30)];
//    huizhangImage.image=[UIImage imageNamed:@"徽章.png"];
//    //huizhangImage.backgroundColor=[UIColor redColor];
//    [backView addSubview:huizhangImage];
    
    return backView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int selectViewNum=1000;
    for (UIViewController * uc in self.parentViewController.childViewControllers) {
        if ([uc isKindOfClass:[UINavigationController class]]) {
            [self.mm_drawerController
             setCenterViewController:uc
             withCloseAnimation:YES
             completion:^(BOOL finished) {
                 
             }];
            
            if (indexPath.row == 0) {
                //我的信息
                selectViewNum=7;
            }else if (indexPath.row == 1){
                //我的日志
                selectViewNum=1;
            }else if (indexPath.row == 2){
                //我的圈子
                selectViewNum=2;
            }else if (indexPath.row == 3){
                //我的成长历程
                selectViewNum = 3;
            }else if (indexPath.row == 4){
                //时间银行
                selectViewNum = 6;
            }else if (indexPath.row == 5){
                //我的组织
                selectViewNum = 5;
            }else if (indexPath.row == 6){
                //我的活动
                selectViewNum = 4;
            }else{
                // NSAssert(YES, @"错误处理");
            }
            [[uc.childViewControllers objectAtIndex:0] pushViewController:selectViewNum];
        }
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[listView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.backgroundColor=[UIColor clearColor];
    }
    UIImageView * topImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, 7.5, 25, 25)];
    //    topImage.backgroundColor=[UIColor blackColor];
    topImage.image=[UIImage imageNamed:[imageArr objectAtIndex:indexPath.row]];
    [cell addSubview:topImage];
    
    UILabel * titleLb=[[UILabel alloc]initWithFrame:CGRectMake(65, 5, 150, 30)];
    titleLb.text=[titleArr objectAtIndex:indexPath.row];
    titleLb.textColor=[UIColor whiteColor];
    titleLb.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    [cell addSubview:titleLb];
    return cell;
}
-(void)setButtonClick
{
    
    for (UIViewController * uc in self.parentViewController.childViewControllers) {
        if ([uc isKindOfClass:[UINavigationController class]]) {
            [self.mm_drawerController
             setCenterViewController:uc
             withCloseAnimation:YES
             completion:^(BOOL finished) {
                 
             }];
            
            [[uc.childViewControllers objectAtIndex:0] pushViewController:0];
        }
    }
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
