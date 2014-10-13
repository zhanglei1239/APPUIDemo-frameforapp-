//
//  FindBackByMailViewController.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindBackByMailViewController : UIViewController
//Step 1
@property (retain,nonatomic) UIButton * btnBack;
@property (retain,nonatomic) UIButton * btnNext;
@property (retain,nonatomic) UIView * step1;
@property (retain,nonatomic) UILabel * lblPleaseInputAccount;
@property (retain,nonatomic) UITextField * account;

//Step 2
@property (retain,nonatomic) UIView * step2;
@property (retain,nonatomic) UIButton * btnLast;
@property (retain,nonatomic) UILabel * lblUserPhoneTitle;
@property (retain,nonatomic) UILabel * lblUserPhone;
@property (retain,nonatomic) UIButton * btnGetMessage;

@end
