//
//  MailSettingViewController.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-5.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "BaseTabViewController.h"

@interface MailSettingViewController : BaseTabViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView_;
}

@end
