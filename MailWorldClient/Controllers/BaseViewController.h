//
//  BaseViewController.h
//  Mailworld
//
//  Created by liyoro on 13-9-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"
#import "Tools.h"
#import "MBProgressHUD.h"
#import "LIUITextField.h"
#import "LIUITextView.h"
#import "MLNavigationController.h"
#import "MailWorldRequest.h"
#import "MailWorldGetRequest.h"

@interface BaseViewController : UIViewController <MBProgressHUDDelegate> {
    
	MBProgressHUD *HUD;
}
@property (nonatomic, assign) BOOL hideBack;

@end
