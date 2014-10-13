//
//  AppDelegate.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;


@end
