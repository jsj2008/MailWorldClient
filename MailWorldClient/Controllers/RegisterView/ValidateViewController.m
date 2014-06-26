//
//  ValidateViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "ValidateViewController.h"
#import "UserInfoViewController.h"
#import "PasswordViewController.h"

#import "UnderLineLabel.h"
#import "RegisterPost.h"

@interface ValidateViewController () {
    LIUITextField *veCodeField;
}

@end

@implementation ValidateViewController

- (IBAction)setPwd:(id)sender {
    PasswordViewController *pwdView = [[PasswordViewController alloc]init];
    pwdView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pwdView animated:YES];
}

- (IBAction)validateNext:(id)sender {
    [veCodeField resignFirstResponder];
    NSString *verCode = veCodeField.text;
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"验证中...";
    [HUD show:YES];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"validation",     @"reqtype",
                         verCode,           @"verCode",
                         [AppConfig phone], @"userMoblie",
                         nil];
    
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"验证失败，请重试！";
            hud.yOffset = -50.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:2];
        }
        else {
            [HUD removeFromSuperview];
            
            if (respond.result == YES) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"验证成功";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
                
                [self performSelector:@selector(setPwd:) withObject:nil afterDelay:2];
                
            }
            else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"验证失败，请重试";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
            }
        }
    }];
//    [RegisterPost validateWithPhone:[AppConfig phone] verCode:verCode andBlock:^(BOOL post, NSError *error) {
//        
//    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"注册";
    
    UILabel *labelTip = [[UILabel alloc]initWithFrame:CGRectMake(28, 20, 280, 21)];
    labelTip.textColor = [UIColor lightGrayColor];
    [labelTip setFont:[UIFont systemFontOfSize:13]];
    labelTip.text = [NSString stringWithFormat:@"包含验证码的短信已发送至%@", [Tools stringForKey:KEY_USER_PHONE]];
    [self.view addSubview:labelTip];
    
    veCodeField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, labelTip.frame.origin.y+labelTip.frame.size.height+8, 280, 38)];
    veCodeField.keyboardType = UIKeyboardTypeNumberPad;
    veCodeField.placeholder = @"输入收到的验证码";
    [self.view addSubview:veCodeField];
    
    UnderLineLabel *labelReSend = [[UnderLineLabel alloc]initWithFrame:CGRectMake(28, veCodeField.frame.origin.y+veCodeField.frame.size.height+10, 120, 21)];
    [labelReSend setFont:[UIFont systemFontOfSize:14]];
    [labelReSend setBackgroundColor:[UIColor clearColor]];
    labelReSend.normalColor = [UIColor colorWithRed:0.658824 green:0.658824 blue:0.647059 alpha:1];
    labelReSend.highlightedColor = [UIColor colorWithRed:0.749020 green:0.749020 blue:0.745098 alpha:1];
    labelReSend.shouldUnderline = YES;
    [labelReSend setText:@"重发验证码"];
    [labelReSend addTarget:self action:@selector(labelClicked)];
    
    [self.view addSubview:labelReSend];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *nextBar = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(validateNext:)];
    self.navigationItem.rightBarButtonItem = nextBar;
    
    [veCodeField becomeFirstResponder];
}

- (void)labelClicked {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"验证短信发送中...";
    [HUD show:YES];
    
    [RegisterPost registerWithPhone:[AppConfig phone] andBlock:^(RegisterPost *post, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"验证短信发送失败，请重试";
            hud.yOffset = -50.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:2];
        }
        else {
            [HUD removeFromSuperview];
            
            if (post.result == YES) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"验证短信发送成功";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
                [self performSelector:@selector(loadValidateView) withObject:nil afterDelay:2];
            }
            else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabelText = post.error_msg;
                hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
