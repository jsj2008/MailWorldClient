//
//  LoginViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "LoginPost.h"
#import "AppDelegate.h"

@interface LoginViewController () {
    LIUITextField *phoneField;
    LIUITextField *pwdField;
}

@end

@implementation LoginViewController

- (void)success {
    [[AppDelegate sharedAppDelegate]loadMainView];
}

- (IBAction)login:(id)sender {
    [phoneField resignFirstResponder];
    [pwdField resignFirstResponder];
    
    NSString *phone = phoneField.text;
    NSString *pwd = pwdField.text;
    
    if (phone.length > 0) {
        if ([Tools isValidateMobile:phone] == NO) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入正确的手机号码！";
            hud.yOffset = -50.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            return;
        }
    }
    else if (phone.length == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入手机号码！";
        hud.yOffset = -50.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        return;
    }
    
    if (pwd.length == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入密码！";
        hud.yOffset = -50.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        return;
    }
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"正在登录...";
    [HUD show:YES];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"login",  @"reqtype",
                         phone,     @"userMoblie",
                         pwd,       @"userPass",
                         nil];
    
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"登录失败，请重试";
            hud.yOffset = -50.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        }
        else {
            [HUD removeFromSuperview];
            if (respond.result == YES) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"登录成功";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
                
                LoginPost *tempDto = [[LoginPost alloc]initWithAttributes:respond.respondData];
                NSString *userid = tempDto.userInfor.userid;
                [Tools saveObject:userid forKey:KEY_USER_ID];
                [Tools saveBool:YES forKey:KEY_IS_LOGIN];
                [self performSelector:@selector(success) withObject:nil afterDelay:2];
            }
            else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabelText = respond.error_msg;
                hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
            }
        }
    }];
//    [LoginPost loginWithPhone:phone password:pwd withBlock:^(LoginPost *post, NSError *error) {
//        
//    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"登录";
    
    phoneField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 38)];
    phoneField.placeholder = @"手机号";
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneField];
    
    pwdField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, phoneField.frame.origin.y+phoneField.frame.size.height+10, 280, 38)];
    pwdField.secureTextEntry = YES;
    pwdField.placeholder = @"请输入密码";
    [self.view addSubview:pwdField];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Tools saveBool:NO forKey:KEY_IS_LOGIN];
    
    UIBarButtonItem *loginBar = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleBordered target:self action:@selector(login:)];
    self.navigationItem.rightBarButtonItem = loginBar;
    
    phoneField.text = [AppConfig phone];
#pragma mark -test
    pwdField.text = @"111111";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
