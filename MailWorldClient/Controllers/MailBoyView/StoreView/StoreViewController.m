//
//  StoreViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-5.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "StoreViewController.h"

#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "KxMenu.h"

#import "MaowustorePost.h"
#import "StoreCell.h"
#import "ShopEntity.h"

@interface StoreViewController () {
    NSInteger currentpage;
    NSInteger ordertype;
}


@end

@implementation StoreViewController

- (void)loadData {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"数据加载中...";
    [HUD show:YES];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"shoplist",                           @"reqtype",
                         [NSNumber numberWithInt:ordertype],    @"Ordertype",
                         [NSNumber numberWithInt:currentpage],  @"currentpage",
                         [NSNumber numberWithInt:10],           @"pagesize",
                         @"22.742",                             @"xpoint",
                         @"114.041",                            @"ypoint",
                         nil];
    
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            
        }
        else {
            [HUD removeFromSuperview];
            
            for (NSDictionary *temList in respond.respondArray) {
                ShopEntity *shop = [[ShopEntity alloc]initWithAttributes:temList];
                [_data addObject:shop];
            }
            [NSTimer scheduledTimerWithTimeInterval:1 target:_tableView selector:@selector(reloadData) userInfo:nil repeats:NO];
        }
    }];
//    [MaowustorePost getMaowustoreWithOrdertype:1 currentpage:currentpage pagesize:10 xpoint:@"22.743370999999999800" ypoint:@"114.041194000000004" andBlock:^(MaowustorePost *post, NSError *error) {
//        
//    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"猫屋门店";
    
    PPiFlatSegmentedControl *segmented = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320, 38) andItems:@[
                                          [NSString stringWithFormat:@"%@ %@",@"距离排序",[NSString fontAwesomeIconStringForEnum:FAIconCaretDown]],
                                          [NSString stringWithFormat:@"%@ %@",@"全部分类",[NSString fontAwesomeIconStringForEnum:FAIconCaretDown]],
                                          [NSString stringWithFormat:@"%@ %@",@"评级排序",[NSString fontAwesomeIconStringForEnum:FAIconCaretDown]],
                                          ] andSelectionBlock:^(NSUInteger segmentIndex, id sender) {
                                              NSLog(@"select:%d", segmentIndex);
                                              [self showMenu:sender];
                                              
                                          }];
//    segmented.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmented.color = [UIColor whiteColor];
    segmented.selectedColor = [UIColor whiteColor];
    segmented.borderWidth = 0.5;
    segmented.borderColor = [UIColor colorWithRed:0.803922 green:0.803922 blue:0.803922 alpha:1];
    segmented.textFont = [UIFont fontWithName:@"FontAwesome" size:14];
    segmented.textColor =         [UIColor colorWithRed:0.552941 green:0.552941 blue:0.552941 alpha:1];
    segmented.selectedTextColor = [UIColor colorWithRed:0.552941 green:0.552941 blue:0.552941 alpha:1];
    [self.view addSubview:segmented];
    
#pragma mark - table
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, segmented.frame.size.height+0.5, self.view.frame.size.width, self.view.frame.size.height-segmented.frame.size.height)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height-segmented.frame.size.height) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    [view1 addSubview:_tableView];
    
    DLog(@"height:%f;%f", self.view.frame.size.height, _tableView.frame.size.height);
    
    // 下拉刷新
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = _tableView;
    
    // 上拉加载更多
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = _tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentpage = 1;
    ordertype = 1;
    
    _data = [[NSMutableArray alloc]init];
    
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_header free];
    [_footer free];
}

//KxMenu
- (void)showMenu:(UIButton *)sender {
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"全部分类"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"美食"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"休闲娱乐"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"电影"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"丽人"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"结婚"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender {
    KxMenuItem *selectItem = (KxMenuItem*)sender;
    NSLog(@"%@", selectItem.title);
}

#pragma mark 数据源-代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopEntity *entry = [_data objectAtIndex:[indexPath row]];
    return [StoreCell heightForEntry:entry withWidth:[[self view] bounds].size.width];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 让刷新控件恢复默认的状态
    [_header endRefreshing];
    [_footer endRefreshing];
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StoreCell";
    StoreCell *cell = (StoreCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[StoreCell alloc] initWithReuseIdentifier:CellIdentifier];
    ShopEntity *entity = [_data objectAtIndex:[indexPath row]];
    [cell setShop:entity];
    
    cell.imageView.image = [UIImage imageNamed:@"homeMenu_boy_on"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (_header == refreshView) {
        for (int i = 0; i<5; i++) {
//            ShopEntity *temp = [[ShopEntity alloc]init];
//            temp.shopname = @"易站（民治店）";
//            temp.shopzhuying = @"主营业务：蒙牛优酸乳买一送一，统一鲜橙多5元2瓶,伊利优酸乳";
//            temp.shopImage = @"http://t-1.tuzhan.com/e10068f6f7d1/p-1/l/2012/09/22/11/af50d5dfc8184e1390843575fd645643.png";
//            temp.distance = @"0.45km";
//            temp.shopgrad = 2;
//            temp.shopmwserver = @"O2O";//自提，O2O
//            [_data addObject:temp];
        }
        
    } else {
        for (int i = 0; i<5; i++) {
//            ShopEntity *temp = [[ShopEntity alloc]init];
//            temp.shopname = @"易站（民治店）2";
//            temp.shopzhuying = @"主营业务：蒙牛优酸乳买一送一，统一鲜橙多5元2瓶2";
//            [_data addObject:temp];
            
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:_tableView selector:@selector(reloadData) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
