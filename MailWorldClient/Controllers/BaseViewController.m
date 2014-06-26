//
//  BaseViewController.m
//  Mailworld
//
//  Created by liyoro on 13-9-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    titleView.text = self.title;
    titleView.font = CHINESE_TITLE_FONT;
    titleView.textColor = [UIColor whiteColor];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (!self.hideBack) {
        UIImage *imgBack = [UIImage imageNamed:@"button_back"];
        UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 51, 32)];
        [btnBack setTitle:@"返回" forState:UIControlStateNormal];
        btnBack.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btnBack setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 8.0, 0.0, 0.0)];
        [btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
        UIBarButtonItem *barBack = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = barBack;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (HUD != nil) {
        [HUD removeFromSuperview];
    }
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
