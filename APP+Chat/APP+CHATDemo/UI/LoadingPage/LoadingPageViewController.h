//
//  LoadingPageViewController.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingPageViewController : UIViewController
@property (retain,nonatomic) UIImageView * userImg;
@property (retain,nonatomic) UIImageView * pwdImg;
@property (retain,nonatomic) UITextField * userText;
@property (retain,nonatomic) UITextField * pwdText;
@property (retain,nonatomic) UIView * lineView1;
@property (retain,nonatomic) UIView * lineView2;
@property (retain,nonatomic) UIButton * btnLog;
@property (retain,nonatomic) UIButton * btnRegist;
@property (retain,nonatomic) UIButton * btnFindBack;
@property (retain,nonatomic) UIView * findBack;
@end
