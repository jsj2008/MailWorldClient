//
//  MainViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-15.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ACPButton.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (IBAction)loadLoginView:(id)sender {
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (IBAction)loadRegisterView:(id)sender {
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.952941 green:0.952941 blue:0.952941 alpha:1];
    
    CGFloat logoImageWidth = 68;
    CGFloat logoImageHeight = 68;
    
    UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mailworld-logo"]];
    [logoImage setFrame:CGRectMake((self.view.frame.size.width-logoImageWidth)/2, self.view.frame.size.height*0.1, logoImageWidth, logoImageHeight)];
    [self.view addSubview:logoImage];
    
    ACPButton *registeBtn = [[ACPButton alloc]initWithFrame:CGRectMake(10, logoImage.frame.origin.y+logoImageHeight+self.view.frame.size.height*0.1, 300, 44)];
    [registeBtn setStyleType:ACPButtonWhite];
    [registeBtn setCornerRadius:3];
    [registeBtn setLabelTextColor:[UIColor colorWithRed:1.000000 green:0.580392 blue:0.305882 alpha:1] highlightedColor:[UIColor colorWithRed:1.000000 green:0.580392 blue:0.305882 alpha:0.7] disableColor:nil];
    [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registeBtn setLabelFont:[UIFont fontWithName:@"Trebuchet MS" size:18]];
    [self.view addSubview:registeBtn];
    
    [registeBtn addTarget:self action:@selector(loadRegisterView:) forControlEvents:UIControlEventTouchUpInside];
    
    ACPButton *loginBtn = [[ACPButton alloc]initWithFrame:CGRectMake(10, registeBtn.frame.origin.y+registeBtn.frame.size.height+8, 300, 44)];
    [loginBtn setStyleType:ACPButtonOrange];
    [loginBtn setCornerRadius:3];
    [loginBtn setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor colorWithRed:0.870588 green:0.878431 blue:0.882353 alpha:1] disableColor:nil];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setLabelFont:[UIFont fontWithName:@"Trebuchet MS" size:18]];
    [self.view addSubview:loginBtn];
    
    [loginBtn addTarget:self action:@selector(loadLoginView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
