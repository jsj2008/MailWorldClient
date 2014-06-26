//
//  O2OViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-22.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "O2OViewController.h"

#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "KxMenu.h"
#import "MJRefresh.h"
#import "GMGridView.h"

#import "O2OType.h"
#import "O2OGoodEntity.h"

@interface O2OViewController () <GMGridViewDataSource, GMGridViewActionDelegate, MJRefreshBaseViewDelegate> {
    GMGridView *_gmGridView;
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSInteger currentpage;
    
    NSMutableArray *_data;
    NSMutableArray *menuItems;
}

@end

@implementation O2OViewController

- (void)loadType {
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"allclassify",                       @"reqtype",
                         nil];
    
    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            
        }
        else {
            [HUD removeFromSuperview];
            
            for (NSDictionary *temList in respond.respondArray) {
                O2OType *o2oType = [[O2OType alloc]initWithAttributes:temList];
                
                KxMenuItem *item = [KxMenuItem menuItem:o2oType.businessDictName
                               image:nil
                              target:nil
                              action:NULL];
                [menuItems addObject:item];
            }
            
        }
    }];
}

- (void)loadData {
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"数据加载中...";
    [HUD show:YES];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"O2OGOODQUERY",                       @"reqtype",
                         [NSNumber numberWithInt:currentpage],  @"pageno",
                         [NSNumber numberWithInt:10],           @"pagesize",
                         nil];
    
//    [MailWorldRequest requestWithParams:dic andBlock:^(MailWorldRequest *respond, NSError *error) {
//        if (error) {
//            [HUD removeFromSuperview];
//            
//        }
//        else {
//            [HUD removeFromSuperview];
//            
//            for (NSDictionary *temList in respond.respondArray) {
//                O2OGoodEntity *good = [[O2OGoodEntity alloc]initWithAttributes:temList];
//                [_data addObject:good];
//            }
//            [NSTimer scheduledTimerWithTimeInterval:1 target:_gmGridView selector:@selector(reloadData) userInfo:nil repeats:NO];
//        }
//    }];
    
    [MailWorldGetRequest requestWithParams:dic andBlock:^(MailWorldGetRequest *respond, NSError *error) {
        if (error) {
            [HUD removeFromSuperview];
            
        }
        else {
            [HUD removeFromSuperview];
            
            for (NSDictionary *temList in respond.respondArray) {
                O2OGoodEntity *good = [[O2OGoodEntity alloc]initWithAttributes:temList];
                [_data addObject:good];
            }
            [NSTimer scheduledTimerWithTimeInterval:1 target:_gmGridView selector:@selector(reloadData) userInfo:nil repeats:NO];
        }
    }];
}

- (void)loadView {
    [super loadView];
    
    self.title = @"O2O";
    
    PPiFlatSegmentedControl *segmented = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320, 38) andItems:@[
                                          [NSString stringWithFormat:@"%@ %@",@"全部分类",[NSString fontAwesomeIconStringForEnum:FAIconCaretDown]],
                                          [NSString stringWithFormat:@"%@ %@",@"默认排序",[NSString fontAwesomeIconStringForEnum:FAIconCaretDown]],
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
    
#pragma mark - table
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, segmented.frame.size.height+0.5, self.view.frame.size.width, self.view.frame.size.height-segmented.frame.size.height)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view1];
    
    NSInteger spacing = 10;
    
    _gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height-segmented.frame.size.height)];
    _gmGridView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gmGridView.backgroundColor = [UIColor whiteColor];
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = YES;
    _gmGridView.actionDelegate = self;
    _gmGridView.dataSource = self;
    
    [view1 addSubview:_gmGridView];
    
    // 下拉刷新
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = _gmGridView;
    
    // 上拉加载更多
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = _gmGridView;
    
    [self.view addSubview:segmented];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentpage = 1;
    
    _data = [[NSMutableArray alloc] init];
    menuItems = [[NSMutableArray alloc]init];
    [self loadData];
//    [self loadType];
}

//KxMenu
- (void)showMenu:(UIButton *)sender {
    int tag = sender.tag;
    DLog(@"tag:%d", tag);
    
//    NSArray *menuItems =
//    @[
//      [KxMenuItem menuItem:@"全部分类"
//                     image:nil
//                    target:nil
//                    action:NULL],
//      
//      [KxMenuItem menuItem:@"美食"
//                     image:nil
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"休闲娱乐"
//                     image:nil
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"电影"
//                     image:nil
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"丽人"
//                     image:nil
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"结婚"
//                     image:nil
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      ];
    
//    KxMenuItem *first = menuItems[0];
//    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
//    first.alignment = NSTextAlignmentCenter;
//    
//    [KxMenu showMenuInView:self.view
//                  fromRect:sender.frame
//                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender {
    KxMenuItem *selectItem = (KxMenuItem*)sender;
    NSLog(@"%@", selectItem.title);
}

#pragma mark GMGridViewDataSource
- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView {
    return [_data count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGSizeMake(170, 135);
    }
    else
    {
        return CGSizeMake(140, 110);
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index {
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell) {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 0;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    O2OGoodEntity *temp = [_data objectAtIndex:index];
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = temp.good_name;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark GMGridViewActionDelegate

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position {
    NSLog(@"Did tap at index %d", position);
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (_header == refreshView) {
//        for (int i = 0; i<5; i++) {
//            [_data insertObject:[formatter stringFromDate:[NSDate date]] atIndex:0];
//        }
        
    } else {
//        for (int i = 0; i<5; i++) {
//            [_data addObject:[formatter stringFromDate:[NSDate date]]];
//        }
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:_gmGridView selector:@selector(reloadData) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
