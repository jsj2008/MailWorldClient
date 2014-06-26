//
//  PasswordViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-21.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "PasswordViewController.h"
#import "LoginViewController.h"

@interface PasswordViewController () {
    LIUITextField *pwdField;
    LIUITextField *repwdField;
}

@end

@implementation PasswordViewController

- (void)loadLoginView {
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (IBAction)submit:(id)sender {
    [pwdField resignFirstResponder];
    [repwdField resignFirstResponder];
    
    NSString *pwd = pwdField.text;
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"setpasswd",          @"reqtype",
                         [AppConfig phone],     @"userMoblie",
                         pwd,                   @"userPass",
                         nil];
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"密码设置失败，请重试";
            hud.yOffset = -50.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
        }
        else {
            [HUD removeFromSuperview];
            if (respond.result == 1) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"密码设置成功";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
                [self performSelector:@selector(loadLoginView) withObject:nil afterDelay:2];
            }
            else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"密码设置失败，请重试";
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
            }
        }
    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"密码设置";
    
    pwdField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 38)];
    pwdField.placeholder = @"请输入密码";
    pwdField.secureTextEntry = YES;
    [self.view addSubview:pwdField];
    
    repwdField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, pwdField.frame.origin.y+pwdField.frame.size.height+10, 280, 38)];
    repwdField.secureTextEntry = YES;
    repwdField.placeholder = @"请确认输入的密码";
    [self.view addSubview:repwdField];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [pwdField becomeFirstResponder];
    
    UIBarButtonItem *loginBar = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = loginBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
