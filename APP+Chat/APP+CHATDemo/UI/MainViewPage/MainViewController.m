//
//  MainViewController.m
//  APP+CHATDemo
//
//  Created by Mac mini on 14-10-9.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//
static const CGFloat kDefaultPlaySoundInterval = 3.0;
#import "MainViewController.h"
#import "CommunicateViewController.h"
#import "LinkmanViewController.h"
#import "ShowPageViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "AddFriendViewController.h"
#import "ChatListViewController.h"
#import "ApplyViewController.h"
@interface MainViewController ()<UIGestureRecognizerDelegate,IChatManagerDelegate>
{
    ChatListViewController * _chatListView;
    LinkmanViewController * _linkmanView;
    ShowPageViewController * _showPageView;
    
    UIBarButtonItem * _addFriendItem;
    UIBarButtonItem * _additionItem;
}
@property (strong, nonatomic)NSDate *lastPlaySoundDate;
@end

@implementation MainViewController

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
    // Do any additional setup after loading the view.
    //判断是否登录 需要走登录流程 以及注册流程
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    isShow=NO;
    
    self.title=@"首页";
    
    [self setupLeftMenuButton];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupSubviews];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:_linkmanView action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    _addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    UIButton *addButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [addButton1 setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
    _additionItem = [[UIBarButtonItem alloc] initWithCustomView:addButton1];
    self.navigationItem.rightBarButtonItem = _additionItem;
    
}

- (void)setupSubviews
{
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    
    _chatListView = [[ChatListViewController alloc] init];
    _chatListView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会话"
                                                           image:nil
                                                             tag:0];
    
    [_chatListView.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_chatsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_chats"]];
    [self unSelectedTapTabBarItems:_chatListView.tabBarItem];
    [self selectedTapTabBarItems:_chatListView.tabBarItem];
    
    _linkmanView = [[LinkmanViewController alloc] init];
    _linkmanView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                           image:nil
                                                             tag:1];
    [_linkmanView.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [self unSelectedTapTabBarItems:_linkmanView.tabBarItem];
    [self selectedTapTabBarItems:_linkmanView.tabBarItem];
    
    _showPageView = [[ShowPageViewController alloc] init];
    _showPageView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                           image:nil
                                                             tag:2];
    [_showPageView.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_settingHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_setting"]];
    _showPageView.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_showPageView.tabBarItem];
    [self selectedTapTabBarItems:_showPageView.tabBarItem];
    
    self.viewControllers = @[_showPageView, _chatListView, _linkmanView];
    [self selectedTapTabBarItems:_showPageView.tabBarItem];
    self.selectedViewController = _showPageView;
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        UITextAttributeFont,[UIColor colorWithRed:0.393 green:0.553 blue:1.000 alpha:1.000],UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
}
#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.title = @"会话";
        self.navigationItem.rightBarButtonItem = nil;
    }else if (item.tag == 1){
        self.title = @"通讯录";
        self.navigationItem.rightBarButtonItem = _addFriendItem;
    }else if (item.tag == 2){
        self.title = @"首页";
        self.navigationItem.rightBarButtonItem = _additionItem;
    }
}

-(void)pushViewController:(NSInteger)viewNum
{
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
                [[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            } onQueue:nil];
        }
    }
    else if (alertView.tag == 100) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    } else if (alertView.tag == 101) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
}


#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}



-(void)setupLeftMenuButton
{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)buttonClick:(UIButton*)button
{
    
}
-(void)otherClick
{
    if (addBackView==nil) {
        addBackView=[[UIView alloc]init];
        addBackView.frame=CGRectMake(180, -120, 140, 90);
        addBackView.alpha=1;
        addBackView.backgroundColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];;
        [self.view addSubview:addBackView];
        otherTitleArr=[NSArray arrayWithObjects:@"   组织查询",@"   活动查询",@"  扫一扫",nil];
        for (int i=0; i<3; i++) {
            UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 30*i, 140, 30)];
            button.backgroundColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
            button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
            [button setTitle:[otherTitleArr objectAtIndex:i] forState:UIControlStateNormal];
            [addBackView addSubview:button];
            
            UIView* lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 30*i, 140, 1)];
            lineView.backgroundColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
            [addBackView addSubview:lineView];
            
            UIImageView* icon=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
            icon.image=[UIImage imageNamed:[NSString stringWithFormat:@"a%d.png",i+1]];
            [icon setContentMode:UIViewContentModeScaleAspectFit];
            [button addSubview:icon];
        }
    }
    if (isShow==YES) {
        [self Hidden];
    }else
    {
        [self Show];
    }
    
    
}
-(void)Hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        addBackView.frame=CGRectMake(180, -120, 140, 90);
        addBackView.alpha=0;
    } completion:^(BOOL finished) {
        [cancelView removeFromSuperview];
        isShow=NO;
    }];
}
-(void)Show
{
    [UIView animateWithDuration:0.3 animations:^{
        addBackView.frame=CGRectMake(180, 0, 140, 90);
        addBackView.alpha=1;
    } completion:^(BOOL finished) {
        cancelView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1000, 1000)];
        cancelView.backgroundColor=[UIColor clearColor];
        cancelView.userInteractionEnabled=YES;
        [self.view addSubview:cancelView];
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidden)];
        singleTap.numberOfTapsRequired=1;
        singleTap.delegate=self;
        [cancelView addGestureRecognizer:singleTap];
        isShow=YES;
    }];
}

-(void)addFriend
{
    AddFriendViewController * addView=[[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:addView animated:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (_chatListView) {
        if (unreadCount > 0) {
            _chatListView.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
        }else{
            _chatListView.tabBarItem.badgeValue = nil;
        }
    }
}

- (void)setupUntreatedApplyCount
{
    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
    if (_linkmanView) {
        if (unreadCount > 0) {
            _linkmanView.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
        }else{
            _linkmanView.tabBarItem.badgeValue = nil;
        }
    }
}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [_chatListView refreshDataSource];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    [self setupUnreadMessageCount];
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupList];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbing) {
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                //        NSInteger minute= [components minute];
                
                NSUInteger startH = options.noDisturbingStartH;
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24;
                }
                
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0);
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversation.chatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }
#endif
    }
}

- (void)playSoundAndVibration{
    
    //如果距离上次响铃和震动时间太短, 则跳过响铃
    NSLog(@"%@, %@", [NSDate date], self.lastPlaySoundDate);
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversation.chatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
        /*NSString *hintText = @"";
         if (error.errorCode != EMErrorServerMaxRetryCountExceeded) {
         if (![[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled]) {
         hintText = @"你的账号登录失败，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];
         }
         } else {
         hintText = @"已达到最大登陆重试次数，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];
         }*/
        NSString *hintText = @"你的账号登录失败，正在重试中... \n点击 '登出' 按钮跳转到登录页面 \n点击 '继续等待' 按钮等待重连成功";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"继续等待"
                                                  otherButtonTitles:@"登出",
                                  nil];
        alertView.tag = 99;
        [alertView show];
    }
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        //发送本地推送
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = [NSString stringWithFormat:@"%@ %@", username, @"添加你为好友"];
        notification.alertAction = @"打开";
        notification.timeZone = [NSTimeZone defaultTimeZone];
    }
#endif
    
    [_linkmanView reloadApplyView];
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [_linkmanView reloadDataSource];
}

- (void)didRemovedByBuddy:(NSString *)username
{
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:username deleteMessages:YES];
    [_chatListView refreshDataSource];
    [_linkmanView reloadDataSource];
}

- (void)didAcceptedByBuddy:(NSString *)username
{
    [_linkmanView reloadDataSource];
}

- (void)didRejectedByBuddy:(NSString *)username{
    NSString *message = [NSString stringWithFormat:@"你被'%@'无耻的拒绝了", username];
    TTAlertNoTitle(message);
}

- (void)didAcceptBuddySucceed:(NSString *)username{
    [_linkmanView reloadDataSource];
}

#pragma mark - IChatManagerDelegate 群组变化

- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
#endif
    
    [_linkmanView reloadGroupView];
}

//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!error) {
#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
#endif
        
        [_linkmanView reloadGroupView];
    }
}

- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason
{
    NSString *message = [NSString stringWithFormat:@"你被'%@'无耻的拒绝了", username];
    TTAlertNoTitle(message);
}


- (void)didReceiveAcceptApplyToJoinGroup:(NSString *)groupId
                               groupname:(NSString *)groupname
{
    NSString *message = [NSString stringWithFormat:@"同意加入群组\'%@\'", groupname];
    [self showHint:message];
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你的账号已在其他地方登录"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 100;
        [alertView show];
    } onQueue:nil];
}

- (void)didRemovedFromServer {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你的账号已被从服务器端移除"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 101;
        [alertView show];
    } onQueue:nil];
}

- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    [_chatListView networkChanged:connectionState];
}

#pragma mark -

- (void)willAutoReconnect{
    [self hideHud];
    [self showHudInView:self.view hint:@"正在重连中..."];
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    [self hideHud];
    if (error) {
        [self showHint:@"重连失败，稍候将继续重连"];
    }else{
        [self showHint:@"重连成功！"];
    }
}

#pragma mark - public

- (void)jumpToChatList
{
    if(_chatListView)
    {
        [self.navigationController popToViewController:self animated:NO];
        [self setSelectedViewController:_chatListView];
    }
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
