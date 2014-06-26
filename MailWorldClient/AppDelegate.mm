//
//  AppDelegate.m
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "AppDelegate.h"
#import "MLNavigationController.h"

#import "AppConfig.h"
#import "Tools.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MobClick.h"

#import "MainViewController.h"

#import "MailHiViewController.h"
#import "MailBoyViewController.h"
#import "MailHomeViewController.h"
#import "MailNeightborViewController.h"
#import "MailSettingViewController.h"

#pragma mark - 邻家男孩
#import "MailBoyViewController.h"
#import "ThemeViewController.h"
#import "SaleViewController.h"
#import "StoreViewController.h"
#import "HouseViewController.h"

#pragma mark - 邻居
#import "MailNeightborViewController.h"
#import "MessageViewController.h"
#import "ContactsViewController.h"
#import "NeightborViewController.h"
#import "NeightborTalkViewController.h"

BMKMapManager* _mapManager;

@implementation AppDelegate {
    Reachability *_reachability;
}

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:APP_CHANNEL];
    [MobClick checkUpdate];
    
	// 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:BAIDU_APPKEY generalDelegate:self];
    //    注意：为了给用户提供更安全的服务，iOS SDK自V2.0.2版本开始采用全新的key验证体系。
    //    因此当你选择使用，V2.0.2及以后版本的SDK时，需要到新的key申请页面进行全新key的申请，申请及配置流程请参考开发指南的对应章节。
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
#pragma mark - nav    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar_bg"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    // Change the appearance of back button
//    UIImage *backButtonImage = [[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Change the appearance of other navigation button
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    if (IOS7_OR_LATER) {
        NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        
        [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
#pragma mark - test
//    [Tools saveBool:NO forKey:KEY_IS_LOGIN];
    
    if ([Tools boolForKey:KEY_IS_LOGIN]==YES) {
        [self loadMainView];
    }
    else {
        MainViewController *mainView = [[MainViewController alloc]init];
        UINavigationController *nacVC = [[UINavigationController alloc]initWithRootViewController:mainView];
        self.window.rootViewController = nacVC;
    }
    
    
    //网络监控
    [self setNetworkReachability];
    
    //错误日志打印
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark - Custom methods
- (void)loadMainView {
    MailHiViewController *hiView = [[MailHiViewController alloc]init];
    UINavigationController *nacVC = [[UINavigationController alloc]initWithRootViewController:hiView];
    nacVC.delegate = self;
    
    MailBoyViewController *mailBoyView = [[MailBoyViewController alloc] init];
    UINavigationController *nacVC1 = [[UINavigationController alloc]initWithRootViewController:mailBoyView];
    nacVC1.delegate = self;
    
    MailHomeViewController *homeView = [[MailHomeViewController alloc]init];
    UINavigationController *homeNac = [[UINavigationController alloc]initWithRootViewController:homeView];
    homeNac.delegate = self;
    
    MailNeightborViewController *mailNeightborView = [[MailNeightborViewController alloc]init];
    UINavigationController *nacVC2 = [[UINavigationController alloc]initWithRootViewController:mailNeightborView];
    nacVC2.delegate = self;

    MailSettingViewController *settingView = [[MailSettingViewController alloc]init];
    UINavigationController *nacVC3 = [[UINavigationController alloc]initWithRootViewController:settingView];
    nacVC3.delegate = self;
    
	NSArray *ctrlArr = [NSArray arrayWithObjects:nacVC, nacVC1, homeNac, nacVC2, nacVC3, nil];
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"homeMenu_hi"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"homeMenu_hi"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"homeMenu_hi_on"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"homeMenu_boy"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"homeMenu_boy"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"homeMenu_boy_on"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"homeMenu_o"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"homeMenu_o"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"homeMenu_o_on"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"homeMenu_friend"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"homeMenu_friend"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"homeMenu_friend_on"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"homeMenu_set"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"homeMenu_set"] forKey:@"Highlighted"];
	[imgDic5 setObject:[UIImage imageNamed:@"homeMenu_set_on"] forKey:@"Seleted"];
    
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic, imgDic2, imgDic3, imgDic4, imgDic5, nil];
	
	self.mainTabBarController = [[GTTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
	[self.mainTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"homeMenu_bg.png"]];
	[self.mainTabBarController setTabBarTransparent:YES];
    [self.mainTabBarController setSelectedIndex:2];
    self.mainTabBarController.delegate = self;
    self.mainTabBarController.animateDriect = 0;
    
    self.window.rootViewController = self.mainTabBarController;
}

//- (void)loadMailBoyView {
//
//    ThemeViewController *themeView = [[ThemeViewController alloc]initWithNibName:@"ThemeViewController" bundle:nil];
//    MLNavigationController *nacVC = [[MLNavigationController alloc]initWithRootViewController:themeView];
//    
//    SaleViewController *saleView =[[SaleViewController alloc]initWithNibName:@"SaleViewController" bundle:nil];
//    MLNavigationController *nacVC1 = [[MLNavigationController alloc]initWithRootViewController:saleView];
//    
//    StoreViewController *storeView = [[StoreViewController alloc]initWithNibName:@"StoreViewController" bundle:nil];
//    MLNavigationController *nacVC2 = [[MLNavigationController alloc]initWithRootViewController:storeView];
//    
//    HouseViewController *houseView = [[HouseViewController alloc]initWithNibName:@"HouseViewController" bundle:nil];
//    MLNavigationController *nacVC3 = [[MLNavigationController alloc]initWithRootViewController:houseView];
//    
//	NSArray *ctrlArr = [NSArray arrayWithObjects:nacVC, nacVC1, @"", nacVC2, nacVC3, nil];
//    
//    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Default"];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Highlighted"];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Default"];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Highlighted"];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Highlighted"];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Default"];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Highlighted"];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Default"];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Highlighted"];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Seleted"];
//    
//	NSArray *imgArr = [NSArray arrayWithObjects:imgDic, imgDic2, imgDic3, imgDic4, imgDic5, nil];
//	
//	self.mailBoyTabBarController = [[GTTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
//	[self.mailBoyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bottom-bg.png"]];
//	[self.mailBoyTabBarController setTabBarTransparent:YES];
//    self.mailBoyTabBarController.delegate = self;
//    self.mailBoyTabBarController.animateDriect = 0;
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.mailBoyTabBarController animated:YES completion:nil];
//}
//
//- (void)loadMailNeightborView {
//    MessageViewController *messageView = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
//    MLNavigationController *nacVC = [[MLNavigationController alloc]initWithRootViewController:messageView];
//    
//    ContactsViewController *contactsView = [[ContactsViewController alloc]initWithNibName:@"ContactsViewController" bundle:nil];
//    MLNavigationController *nacVC1 = [[MLNavigationController alloc]initWithRootViewController:contactsView];
//    
//    NeightborViewController *neightborView = [[NeightborViewController alloc]initWithNibName:@"NeightborViewController" bundle:nil];
//    MLNavigationController *nacVC2 = [[MLNavigationController alloc]initWithRootViewController:neightborView];
//    
//    NeightborTalkViewController *neightborTalkView = [[NeightborTalkViewController alloc]initWithNibName:@"NeightborTalkViewController" bundle:nil];
//    MLNavigationController *nacVC3 = [[MLNavigationController alloc]initWithRootViewController:neightborTalkView];
//    
//	NSArray *ctrlArr = [NSArray arrayWithObjects:nacVC, nacVC1, @"", nacVC2, nacVC3, nil];
//    
//    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Default"];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Highlighted"];
//	[imgDic setObject:[UIImage imageNamed:@"theme.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Default"];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Highlighted"];
//	[imgDic2 setObject:[UIImage imageNamed:@"sale.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Highlighted"];
//	[imgDic3 setObject:[UIImage imageNamed:@"home.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Default"];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Highlighted"];
//	[imgDic4 setObject:[UIImage imageNamed:@"store.png"] forKey:@"Seleted"];
//    
//	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Default"];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Highlighted"];
//	[imgDic5 setObject:[UIImage imageNamed:@"house.png"] forKey:@"Seleted"];
//    
//	NSArray *imgArr = [NSArray arrayWithObjects:imgDic, imgDic2, imgDic3, imgDic4, imgDic5, nil];
//	
//	self.mailNeightborTabBarController = [[GTTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
//	[self.mailNeightborTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bottom-bg.png"]];
//	[self.mailNeightborTabBarController setTabBarTransparent:YES];
//    self.mailNeightborTabBarController.delegate = self;
//    self.mailNeightborTabBarController.animateDriect = 0;
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.mailNeightborTabBarController animated:YES completion:nil];
//    
//}

#pragma mark NavigationDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.hidesBottomBarWhenPushed) {
        [self.mainTabBarController hidesTabBar:YES animated:YES];
    }
    else {
        [self.mainTabBarController hidesTabBar:NO animated:YES];
    }
}

- (void)tabBarController:(GTTabBarController *)tabBarController didSelectIndex:(NSInteger)index {
//    NSLog(@"didSelectIndex:%d", index);
//    if (tabBarController == self.mainTabBarController) {
//        [self loadMailBoyView];
//    }
//    else if (tabBarController == self.mailBoyTabBarController) {
//        [self.mailBoyTabBarController dismissViewControllerAnimated:YES completion:nil];
//    }
}

#pragma mark - Bdidu
- (void)onGetNetworkState:(int)iError {
    NSLog(@"onGetNetworkState %d",iError);
}

- (void)onGetPermissionState:(int)iError {
    NSLog(@"onGetPermissionState %d",iError);
}

- (void)setNetworkReachability {
    //起动网络状态监视
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
    _reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reachability startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    _networkStatus = status;
}

void uncaughtExceptionHandler(NSException *exception) {
    DLog(@"CRASH: %@", exception);
    DLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

@end
