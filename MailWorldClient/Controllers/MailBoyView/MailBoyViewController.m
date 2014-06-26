//
//  MailBoyViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-6.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailBoyViewController.h"

#import "ThemeViewController.h"
#import "CategoryViewController.h"
#import "SaleViewController.h"
#import "StoreViewController.h"
#import "HouseViewController.h"

@interface MailBoyViewController ()

@end

@implementation MailBoyViewController

- (void)loadView {
    [super loadView];
    
    self.title = @"邻家男孩";
    
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
    
//    if (IOS7_OR_LATER) {
//        
//    }
//    else if (IS_IPHONE_5) {
//        [self.view setFrame:CGRectMake(0, 0, 320, 460)];
//    }
//    else {
//        [self.view setFrame:CGRectMake(0, 0, 320, 548)];
//    }
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0: {
            return 4;
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mailBoyCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mailBoyCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"专题活动";
                    cell.imageView.image = [UIImage imageNamed:@"ic_b_gift"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"门店促销";
                    cell.imageView.image = [UIImage imageNamed:@"ic_b_sale"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"猫屋门店";
                    cell.imageView.image = [UIImage imageNamed:@"ic_b_store"];
                    
                    return cell;
                }
                case 3: {
                    cell.textLabel.text = @"我的屋";
                    cell.imageView.image = [UIImage imageNamed:@"ic_b_house"];
                    
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
                case 0: {//专题活动
                    ThemeViewController *themeView = [[ThemeViewController alloc]init];
                    themeView.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:themeView animated:YES];
                }
                    break;
                case 1: {//门店促销
                    CategoryViewController *categoryView = [[CategoryViewController alloc]init];
                    categoryView.hidesBottomBarWhenPushed = YES;
//                    categoryView.hideBack = NO;
                    [self.navigationController pushViewController:categoryView animated:YES];
                }
                    break;
                case 2: {//猫屋门店
                    StoreViewController *storeView = [[StoreViewController alloc]init];
                    storeView.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:storeView animated:YES];
                }
                    break;
                case 3: {//我的屋
                    HouseViewController *houseView = [[HouseViewController alloc]init];
                    houseView.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:houseView animated:YES];
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
