//
//  RegisterPageViewController.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPageViewController : UIViewController<UITextFieldDelegate>

@property (retain,nonatomic) UILabel * lblName;
@property (retain,nonatomic) UITextField * name;
@property (retain,nonatomic) UIView * nameLine;

@property (retain,nonatomic) UILabel * lblPwd;
@property (retain,nonatomic) UITextField * pwd;
@property (retain,nonatomic) UIView * pwdLine;

@property (retain,nonatomic) UILabel * lblPhoneNum;
@property (retain,nonatomic) UITextField * phoneNum;
@property (retain,nonatomic) UIView * phoneNumLine;

@property (retain,nonatomic) UILabel * lblMail;
@property (retain,nonatomic) UITextField * mail;
@property (retain,nonatomic) UIView * mailLine;
@property (retain,nonatomic) UIButton * btnGetPwd;

@property (retain,nonatomic) UIButton * btnConfirm;
@property (retain,nonatomic) UIButton * btnCancel;

@property (assign,nonatomic) BOOL isYanzheng;
@end
