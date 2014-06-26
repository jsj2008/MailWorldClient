//
//  StoreViewController.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-5.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//    猫屋门店

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface StoreViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate> {
    
    UITableView *_tableView;
    
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *_data;
}

@end
