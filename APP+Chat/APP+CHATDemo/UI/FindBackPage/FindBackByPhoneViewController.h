//
//  FindBackByPhoneViewController.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindBackByPhoneViewController :  UIViewController<UITextFieldDelegate>
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
@property (retain,nonatomic) UIButton * btnConfirm;
@property (retain,nonatomic) UITextField * msg;

//Step 3
@property (retain,nonatomic) UIView * step3;
@property (retain,nonatomic) UILabel * lblPwdTitle;
@property (retain,nonatomic) UITextField * pwd;
@property (retain,nonatomic) UILabel * lblConfirmPwdTitle;
@property (retain,nonatomic) UITextField * confirmPwd;
@property (retain,nonatomic) UIButton * btnFix;
@end
