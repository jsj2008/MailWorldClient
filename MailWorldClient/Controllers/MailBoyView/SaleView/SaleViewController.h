//
//  SaleViewController.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-5.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//    门店优惠

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface SaleViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate> {
    
    UITableView *_tableView;
    
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *_data;
}

@end
