//
//  RegisterViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "RegisterViewController.h"
#import "ValidateViewController.h"

#import "RegisterPost.h"

@interface RegisterViewController () {
    LIUITextField *phoneField;
}

@end

@implementation RegisterViewController

- (void)loadValidateView {
    ValidateViewController *validateView = [[ValidateViewController alloc]init];
    validateView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:validateView animated:YES];
}

- (IBAction)registerNext:(id)sender {
    [phoneField resignFirstResponder];
    NSString *phone = phoneField.text;
    [Tools saveObject:phone forKey:KEY_USER_PHONE];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"验证短信发送中...";
    [HUD show:YES];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"reg",    @"reqtype",
                         phone,     @"userMoblie",
                         nil];
    
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
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
            
            if (respond.result == YES) {
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
                hud.detailsLabelText = respond.error_msg;
                hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
                hud.yOffset = -50.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
            }
        }
    }];
//    [RegisterPost registerWithPhone:phone andBlock:^(RegisterPost *post, NSError *error) {
//        
//    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"注册";
    
    phoneField = [[LIUITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 38)];
    phoneField.placeholder = @"请输入你的手机号";
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneField];
    
    UILabel *labelTip = [[UILabel alloc]initWithFrame:CGRectMake(20, phoneField.frame.origin.y+phoneField.frame.size.height+10, 280, 21)];
    labelTip.textColor = [UIColor lightGrayColor];
    [labelTip setFont:[UIFont systemFontOfSize:13]];
    labelTip.text = @"为了验证你的身份，我们将会发送短信验证码";
    [self.view addSubview:labelTip];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *nextBar = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(registerNext:)];
    self.navigationItem.rightBarButtonItem = nextBar;
    
    [phoneField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
