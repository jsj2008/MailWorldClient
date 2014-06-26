//
//  MailSettingViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-5.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailSettingViewController.h"
#import "LoginViewController.h"
#import "SevenSwitch.h"

@interface MailSettingViewController () {
    
}

@end

@implementation MailSettingViewController

- (void)loadView {
    [super loadView];
    
    self.title = @"喵设置";
    
    if (IOS7_OR_LATER) {
        tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-53) style:UITableViewStyleGrouped];
    }
    else {
        tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    }
    tableView_.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView_.delegate = self;
    tableView_.dataSource = self;
    tableView_.backgroundColor = [UIColor whiteColor];
    tableView_.backgroundView = nil;
    [self.view addSubview:tableView_];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0: {
            return 3;
        }
        case 1: {
            return 3;
        }
        case 2: {
            return 2;
        }
        case 3: {
            return 2;
        }
        case 4: {
            return 1;
        }
        default:
            return 0;
            
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingSwitchCell"];
                    cell.textLabel.font = CHINESE_TEXT_FONT;
                    cell.textLabel.text = @"身边打折优惠提醒";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_notice"];
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
                    
                    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(230, 6, 60, 31)];
                    mySwitch.tag = indexPath.row;
                    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
                    mySwitch.onTintColor = kOrangeColor;
                    mySwitch.shadowColor = [UIColor lightGrayColor];
                    [cell.contentView addSubview:mySwitch];
                    
                    if ([Tools boolForKey:kDiscountAlert] == YES) {
                        [mySwitch setOn:YES animated:YES];
                    }
                    else {
                        [mySwitch setOn:NO animated:YES];
                    }
                    return cell;
                }
                case 1: {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingSwitchCell"];
                    cell.textLabel.font = CHINESE_TEXT_FONT;
                    cell.textLabel.text = @"时节养生提醒";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_notice"];
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
                    
                    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(230, 6, 60, 31)];
                    mySwitch.tag = indexPath.row;
                    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
                    mySwitch.onTintColor = kOrangeColor;
                    mySwitch.shadowColor = [UIColor lightGrayColor];
                    [cell.contentView addSubview:mySwitch];
                    
                    if ([Tools boolForKey:kSeasonRegimenAlert] == YES) {
                        [mySwitch setOn:YES animated:YES];
                    }
                    else {
                        [mySwitch setOn:NO animated:YES];
                    }
                    return cell;
                }
                case 2: {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingSwitchCell"];
                    cell.textLabel.font = CHINESE_TEXT_FONT;
                    cell.textLabel.text = @"站内公告";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_notice"];
                    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                    cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
                    
                    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(230, 6, 60, 31)];
                    mySwitch.tag = indexPath.row;
                    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
                    mySwitch.onTintColor = kOrangeColor;
                    mySwitch.shadowColor = [UIColor lightGrayColor];
                    [cell.contentView addSubview:mySwitch];
                    
                    if ([Tools boolForKey:kAnnounceAlert] == YES) {
                        [mySwitch setOn:YES animated:YES];
                    }
                    else {
                        [mySwitch setOn:NO animated:YES];
                    }
                    return cell;
                }
                default: {
                }
            }
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"修改密码";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_lock"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"隐身登录";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_hide"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"黑名单";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_back_men"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"意见反馈";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_suggest"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"帮助中心";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_faq"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"关于我们";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_aboutUS"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"客服电话";
                    cell.imageView.image = [UIImage imageNamed:@"s_ic_tel"];
                    cell.detailTextLabel.text = @"400-100-9111";
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 4: {//退出
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor colorWithRed:0.125490 green:0.658824 blue:0.874510 alpha:1];
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = [UIColor whiteColor];
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"退出";
                    
                    return cell;
                }
                default: {
                }
            }
        }
    }
    
    return [[UITableViewCell alloc] init];
}

- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            switch (indexPath.row) {
                case 0: {//修改密码
                }
                    break;
                case 1: {//隐身登录
                    
                }
                    break;
                case 2: {//黑名单
                    
                }
                    break;
            }
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: {//意见反馈
                }
                    break;
                case 1: {//帮助中心
                    
                }
                    break;
            }
        }
            break;
        case 3: {
            switch (indexPath.row) {
                case 0: {//关于我们
                }
                    break;
                case 1: {//客服电话
                    
                }
                    break;
            }
        }
            break;
        case 4: {
            switch (indexPath.row) {
                case 0: {//退出
                    [Tools saveBool:NO forKey:KEY_IS_LOGIN];
                    LoginViewController *loginView = [[LoginViewController alloc]init];
                    loginView.hideBack = YES;
                    UINavigationController *nacVC = [[UINavigationController alloc]initWithRootViewController:loginView];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nacVC;
                }
                    break;
            }
        }
            break;
        default:{
            
        }
    }
    [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}

@end
