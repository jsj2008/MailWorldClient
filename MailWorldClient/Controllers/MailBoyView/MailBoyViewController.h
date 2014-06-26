//
//  MailBoyViewController.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-6.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "BaseTabViewController.h"

@interface MailBoyViewController : BaseTabViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView_;
}

@end
