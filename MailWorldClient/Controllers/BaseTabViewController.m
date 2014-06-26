//
//  BaseTabViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "BaseTabViewController.h"

@interface BaseTabViewController ()

@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    titleView.text = self.title;
    titleView.font = CHINESE_TITLE_FONT;
    titleView.textColor = [UIColor whiteColor];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
