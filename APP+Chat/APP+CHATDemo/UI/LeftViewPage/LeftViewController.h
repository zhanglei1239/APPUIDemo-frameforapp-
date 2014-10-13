//
//  LeftViewController.h
//  Volunteer
//
//  Created by zsl on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * listView;
    NSArray * titleArr;
    NSArray * imageArr;
}

@end
