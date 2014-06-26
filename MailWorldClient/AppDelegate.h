//
//  AppDelegate.h
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "GTTabBarController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, GTTabBarControllerDelegate, BMKGeneralDelegate> 

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) GTTabBarController *mainTabBarController;
//@property (nonatomic, strong) GTTabBarController *mailBoyTabBarController;
//@property (nonatomic, strong) GTTabBarController *mailNeightborTabBarController;

@property (nonatomic) NetworkStatus networkStatus;

- (void)loadMainView;
//- (void)loadMailBoyView;
//- (void)loadMailNeightborView;

+ (AppDelegate *)sharedAppDelegate;

@end
