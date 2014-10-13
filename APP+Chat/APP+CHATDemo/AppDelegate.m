//
//  AppDelegate.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingPageViewController.h"
#import "ApplyViewController.h"
#import "IntroductoryPageViewController.h"
#import "MainViewController.h"
#import <Foundation/Foundation.h>
#import "IChatManagerDelegate.h"

#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    
#if !TARGET_IPHONE_SIMULATOR
    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
    UIRemoteNotificationTypeSound |
    UIRemoteNotificationTypeAlert;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
#endif
    
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"zhanglei#easemessagetestproj" apnsCertName:nil];
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#warning 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
#warning 如果使用MagicalRecord, 要加上这句初始化MagicalRecord
    //demo coredata, .pch中有相关头文件引用
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"UIDemo"]];
    
    [self loginStateChange:nil];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
    
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidEnterBackground" object:nil];
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[ApplyViewController shareController] addNewApply:dic];
    if (_mainController) {
        [_mainController setupUntreatedApplyCount];
    }
}

#pragma mark - IChatManagerDelegate 群组变化

- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
    if (!groupId || !username) {
        return;
    }
    
    NSString *groupName = groupId;
    if (!message || message.length == 0) {
        message = [NSString stringWithFormat:@"%@ 邀请你加入群组\'%@\'", username, groupName];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupName, @"groupId":groupId, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleGroupInvitation]}];
    [[ApplyViewController shareController] addNewApply:dic];
    if (_mainController) {
        [_mainController setupUntreatedApplyCount];
    }
}

//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!groupId || !username) {
        return;
    }
    
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'", username, groupname];
    }
    else{
        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'：%@", username, groupname, reason];
    }
    
    if (error) {
        NSString *message = [NSString stringWithFormat:@"发送申请失败:%@\n原因：%@", reason, error.description];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupname, @"groupId":groupId, @"username":username, @"groupname":groupname, @"applyMessage":reason, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleJoinGroup]}];
        [[ApplyViewController shareController] addNewApply:dic];
        if (_mainController) {
            [_mainController setupUntreatedApplyCount];
        }
    }
}

- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
                                   groupname:(NSString *)groupname
                                      reason:(NSString *)reason
{
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", groupname];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请提示" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    NSString *tmpStr = group.groupSubject;
    NSString *str;
    if (!tmpStr || tmpStr.length == 0) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *obj in groupArray) {
            if ([obj.groupId isEqualToString:group.groupId]) {
                tmpStr = obj.groupSubject;
                break;
            }
        }
    }
    
    if (reason == eGroupLeaveReason_BeRemoved) {
        str = [NSString stringWithFormat:@"你被从群组\'%@\'中踢出", tmpStr];
    }
    if (str.length > 0) {
        TTAlertNoTitle(str);
    }
}

#pragma mark - push

- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        TTAlertNoTitle(@"消息推送与设备绑定失败");
    }
}

#pragma mark - private

-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    NSUserDefaults * de = [NSUserDefaults standardUserDefaults];
    //如果是第一次登陆 展示用户引导
    if (de == nil || ![[de objectForKey:@"firstload"] boolValue]) {
        IntroductoryPageViewController * view = [[IntroductoryPageViewController alloc] init];
        self.window.rootViewController = view;
        [de setBool:YES forKey:@"firstload"];
    }
    //如果不是第一次登陆 但是
    else if(!isAutoLogin&&!loginSuccess){
        LoadingPageViewController * view = [[LoadingPageViewController alloc] init];
        self.window.rootViewController = view;
    }else{
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        
        LeftViewController * leftView=[[LeftViewController alloc]init];
        MainViewController * mainView=[[MainViewController alloc]init];
        RightViewController * rightView=[[RightViewController alloc]init];
        
        UINavigationController * mainNav=[[UINavigationController alloc]initWithRootViewController:mainView];
        
        MMDrawerController * drawerController = [[MMDrawerController alloc]
                                                 initWithCenterViewController:mainNav
                                                 leftDrawerViewController:leftView
                                                 rightDrawerViewController:nil];
        [drawerController setMaximumRightDrawerWidth:200];
        [drawerController setMaximumLeftDrawerWidth:250];
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [drawerController
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block;
             block = [[MMExampleDrawerVisualStateManager sharedManager]
                      drawerVisualStateBlockForDrawerSide:drawerSide];
             if(block){
                 block(drawerController, drawerSide, percentVisible);
             }
         }];
        nav = [[UINavigationController alloc] initWithRootViewController:drawerController];
        if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
            nav.navigationBar.barStyle = UIBarStyleDefault;
            [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                    forBarMetrics:UIBarMetricsDefault];
            
            [nav.navigationBar.layer setMasksToBounds:YES];
        }
        
        self.window.rootViewController = drawerController;
        [nav setNavigationBarHidden:YES];
        [nav setNavigationBarHidden:NO];
    }
    
    
    
}

@end
