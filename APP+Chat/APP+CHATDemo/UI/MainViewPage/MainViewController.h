//
//  MainViewController.h
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController
{
    NSArray * otherTitleArr;
    UIView * addBackView;
    BOOL isShow;
    UIView *cancelView;
}
-(void)pushViewController:(NSInteger)viewNum;
- (void)jumpToChatList;
- (void)setupUntreatedApplyCount;

@end
