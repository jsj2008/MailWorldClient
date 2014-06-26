//
//  MailHouseViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-10.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailHouseViewController.h"

@interface MailHouseViewController ()

@end

@implementation MailHouseViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)loadView {
    [super loadView];
    
    self.title = @"我的屋";
    
    tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableView_.delegate = self;
    tableView_.dataSource = self;
    tableView_.backgroundColor = [UIColor whiteColor];
    tableView_.backgroundView = nil;
    [self.view addSubview:tableView_];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 0;
    }
    else {
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0: {
            return 1;
        }
        case 1: {
            return 3;
        }
        case 2: {
            return 3;
        }
        case 3: {
            return 2;
        }
        case 4: {
            return 3;
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mailhouseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mailhouseCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"猫币";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_cat_currency"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"消费记录";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_consumer_records"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"会员介绍";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_member_Introduction"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mailhouseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mailhouseCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"我的预定";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_my_book"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"我的订单";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_my_orderlist"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"我的评价";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_my_appraisal"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mailhouseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mailhouseCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"二维码名片";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_dimensional_code_card"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"添加好友";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_addfriends"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
        case 4: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mailhouseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mailhouseCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"收货地址管理";
                    cell.imageView.image = [UIImage imageNamed:@""];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"门店收藏";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_favorite_stores"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"设置";
                    cell.imageView.image = [UIImage imageNamed:@"ic_m_h_setting"];
                    
                    return cell;
                }
                default: {
                }
            }
        }
    }
    return [[UITableViewCell alloc] init];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {//
                    
                }
                    break;
            }
        }
            break;
        case 1: {
            switch (indexPath.row) {
                case 0: {//猫币
                }
                    break;
                case 1: {//消费记录
                    
                }
                    break;
                case 2: {//会员介绍
                    
                }
                    break;
            }
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: {//我的预定
                }
                    break;
                case 1: {//我的订单
                    
                }
                    break;
                case 2: {//我的评价
                    
                }
                    break;
            }
        }
            break;
        case 3: {
            switch (indexPath.row) {
                case 0: {//二维码名片
                }
                    break;
                case 1: {//添加好友
                    
                }
                    break;
            }
        }
            break;
        case 4: {
            switch (indexPath.row) {
                case 0: {//收货地址管理
                }
                    break;
                case 1: {//门店收藏
                    
                }
                    break;
                case 2: {//设置
                    
                }
                    break;
            }
        }
        default:{
            
        }
    }
    [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
