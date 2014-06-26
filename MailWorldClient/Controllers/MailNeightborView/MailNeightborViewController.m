//
//  MailNeightborViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-6.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailNeightborViewController.h"

@interface MailNeightborViewController ()

@end

@implementation MailNeightborViewController

- (void)loadView {
    [super loadView];
    
    self.title = @"邻居好友";
    
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
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"neightborCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"neightborCell"];
                cell.textLabel.font = CHINESE_TEXT_FONT;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = kCell_SELECT_COLOR;
            }
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"消息";
                    cell.imageView.image = [UIImage imageNamed:@"ic_n_msg"];
                    
                    return cell;
                }
                case 1: {
                    cell.textLabel.text = @"联系人";
                    cell.imageView.image = [UIImage imageNamed:@"ic_n_contact"];
                    
                    return cell;
                }
                case 2: {
                    cell.textLabel.text = @"邻居";
                    cell.imageView.image = [UIImage imageNamed:@"ic_n_neightbor"];
                    
                    return cell;
                }
                case 3: {
                    cell.textLabel.text = @"邻居说说";
                    cell.imageView.image = [UIImage imageNamed:@"ic_n_talk"];
                    
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
                case 0: {//消息
                }
                    break;
                case 1: {//联系人
                    
                }
                    break;
                case 2: {//邻居
                    
                }
                    break;
                case 3: {//邻居说说
                    
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
