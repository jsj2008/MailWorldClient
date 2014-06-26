//
//  CategoryViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "CategoryViewController.h"
#import "SaleViewController.h"

@interface CategoryViewController () {
    UIScrollView *contentView;
}

@end

@implementation CategoryViewController

- (void)loadView {
    [super loadView];
    
    self.title = @"门店促销";
    
    CGSize offsets = CGSizeMake(10.0f, 10.0f);
    
    contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    
#pragma mark ---
    UIImageView *bgCook = [[UIImageView alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, 300*0.65, 88)];
    bgCook.image = [UIImage imageNamed:@"banner_cook"];
    [contentView addSubview:bgCook];
    
    NSLog(@"门店促销:%f", 300*0.35-offsets.width);
    
    UIColor *cookColor = [UIColor colorWithRed:0.266667 green:0.537255 blue:0.192157 alpha:1];
    
    UIView *viewCook = [[UIView alloc]initWithFrame:CGRectMake(offsets.width+bgCook.frame.size.width+offsets.width, offsets.width, 300*0.35-offsets.width, 88)];
    viewCook.backgroundColor = cookColor;
    [contentView addSubview:viewCook];
    
    UILabel *labelCook = [[UILabel alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, viewCook.frame.size.width-offsets.width*2, 21)];
    labelCook.text = @"餐饮美食";
    labelCook.backgroundColor = [UIColor clearColor];
    labelCook.textColor = [UIColor whiteColor];
    labelCook.font = [UIFont boldSystemFontOfSize:15];
    [viewCook addSubview:labelCook];
    
    UIImageView *icCook = [[UIImageView alloc]initWithFrame:CGRectMake(viewCook.frame.size.width-offsets.width-22, viewCook.frame.size.height-offsets.height-22, 22, 22)];
    icCook.image = [UIImage imageNamed:@"ic_cook"];
    [viewCook addSubview:icCook];
    
    DWTagList *coodTag = [[DWTagList alloc] initWithFrame:CGRectMake(offsets.width, bgCook.frame.size.height+offsets.height*2, 300.0f, 50.0f)];
    coodTag.tag = 1;
    [coodTag setAutomaticResize:YES];
    [coodTag setBorderColor:cookColor];
    coodTag.highlightedBackgroundColor = [UIColor colorWithRed:0.266667 green:0.537255 blue:0.192157 alpha:0.7];
    NSArray *array = [[NSArray alloc] initWithObjects:@"特色小吃", @"面包甜点", @"火锅", @"日韩料理", @"粤菜", @"湘菜", @"西餐", nil];
    [coodTag setTags:array];
    [coodTag setTagDelegate:self];
    [contentView addSubview:coodTag];
    
#pragma mark ---
    UIImageView *bgDrink = [[UIImageView alloc]initWithFrame:CGRectMake(offsets.width, coodTag.frame.origin.y+coodTag.frame.size.height+offsets.height, 300*0.65, 88)];
    bgDrink.image = [UIImage imageNamed:@"banner_drink"];
    [contentView addSubview:bgDrink];
    
    UIColor *colorDrink = [UIColor colorWithRed:0.600000 green:0.400000 blue:0.760784 alpha:1];
    
    UIView *viewDrink = [[UIView alloc]initWithFrame:CGRectMake(offsets.width+bgDrink.frame.size.width+offsets.width, bgDrink.frame.origin.y, 300*0.35-offsets.width, 88)];
    viewDrink.backgroundColor = colorDrink;
    [contentView addSubview:viewDrink];
    
    UILabel *labelDrink = [[UILabel alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, viewDrink.frame.size.width-offsets.width*2, 21)];
    labelDrink.text = @"休闲娱乐";
    labelDrink.backgroundColor = [UIColor clearColor];
    labelDrink.textColor = [UIColor whiteColor];
    labelDrink.font = [UIFont boldSystemFontOfSize:15];
    [viewDrink addSubview:labelDrink];
    
    UIImageView *icDrink = [[UIImageView alloc]initWithFrame:CGRectMake(viewDrink.frame.size.width-offsets.width-22, viewDrink.frame.size.height-offsets.height-22, 22, 22)];
    icDrink.image = [UIImage imageNamed:@"ic_drink"];
    [viewDrink addSubview:icDrink];
    
    DWTagList *drinkTag = [[DWTagList alloc] initWithFrame:CGRectMake(offsets.width, bgDrink.frame.origin.y+bgDrink.frame.size.height+offsets.height, 300.0f, 50.0f)];
    drinkTag.tag = 2;
    [drinkTag setAutomaticResize:YES];
    [drinkTag setBorderColor:colorDrink];
    drinkTag.highlightedBackgroundColor = [UIColor colorWithRed:0.600000 green:0.400000 blue:0.760784 alpha:0.7];
    NSArray *arrayDrink = [[NSArray alloc] initWithObjects:@"KTV", @"世界之窗啤酒节", @"野外活动", @"摘荔枝", @"摘草莓", nil];
    [drinkTag setTags:arrayDrink];
    [drinkTag setTagDelegate:self];
    [contentView addSubview:drinkTag];
    
#pragma mark --- 丽人
    UIImageView *bgPerfet = [[UIImageView alloc]initWithFrame:CGRectMake(offsets.width, drinkTag.frame.origin.y+drinkTag.frame.size.height+offsets.height, 300*0.65, 88)];
    bgPerfet.image = [UIImage imageNamed:@"banner_perfet"];
    [contentView addSubview:bgPerfet];
    
    UIColor *colorPerfet = [UIColor colorWithRed:1.000000 green:0.592157 blue:0.207843 alpha:1];
    
    UIView *viewPerfet = [[UIView alloc]initWithFrame:CGRectMake(offsets.width+bgPerfet.frame.size.width+offsets.width, bgPerfet.frame.origin.y, 300*0.35-offsets.width, 88)];
    viewPerfet.backgroundColor = colorPerfet;
    [contentView addSubview:viewPerfet];
    
    UILabel *labelPerfet = [[UILabel alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, viewPerfet.frame.size.width-offsets.width*2, 21)];
    labelPerfet.text = @"丽人";
    labelPerfet.backgroundColor = [UIColor clearColor];
    labelPerfet.textColor = [UIColor whiteColor];
    labelPerfet.font = [UIFont boldSystemFontOfSize:15];
    [viewPerfet addSubview:labelPerfet];
    
    UIImageView *icPerfet = [[UIImageView alloc]initWithFrame:CGRectMake(viewPerfet.frame.size.width-offsets.width-22, viewPerfet.frame.size.height-offsets.height-22, 22, 22)];
    icPerfet.image = [UIImage imageNamed:@"ic_perfet"];
    [viewPerfet addSubview:icPerfet];
    
    DWTagList *perfetTag = [[DWTagList alloc] initWithFrame:CGRectMake(offsets.width, bgPerfet.frame.origin.y+bgPerfet.frame.size.height+offsets.height, 300.0f, 50.0f)];
    perfetTag.tag = 3;
    [perfetTag setAutomaticResize:YES];
    [perfetTag setBorderColor:colorPerfet];
    perfetTag.highlightedBackgroundColor = [UIColor colorWithRed:1.000000 green:0.592157 blue:0.207843 alpha:0.7];
    NSArray *arrayPerfet = [[NSArray alloc] initWithObjects:@"美容美体", @"美甲美脚", @"美发", @"瑜伽/舞蹈", nil];
    [perfetTag setTags:arrayPerfet];
    [perfetTag setTagDelegate:self];
    [contentView addSubview:perfetTag];
    
#pragma mark --- 生活服务
    UIImageView *bgLife = [[UIImageView alloc]initWithFrame:CGRectMake(offsets.width, perfetTag.frame.origin.y+perfetTag.frame.size.height+offsets.height, 300*0.65, 88)];
    bgLife.image = [UIImage imageNamed:@"banner_life"];
    [contentView addSubview:bgLife];
    
    UIColor *colorLife = [UIColor colorWithRed:0.164706 green:0.541176 blue:0.858824 alpha:1];
    
    UIView *viewLife = [[UIView alloc]initWithFrame:CGRectMake(offsets.width+bgLife.frame.size.width+offsets.width, bgLife.frame.origin.y, 300*0.35-offsets.width, 88)];
    viewLife.backgroundColor = colorLife;
    [contentView addSubview:viewLife];
    
    UILabel *labelLife = [[UILabel alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, viewLife.frame.size.width-offsets.width*2, 21)];
    labelLife.text = @"生活服务";
    labelLife.backgroundColor = [UIColor clearColor];
    labelLife.textColor = [UIColor whiteColor];
    labelLife.font = [UIFont boldSystemFontOfSize:15];
    [viewLife addSubview:labelLife];
    
    UIImageView *icLife = [[UIImageView alloc]initWithFrame:CGRectMake(viewLife.frame.size.width-offsets.width-22, viewLife.frame.size.height-offsets.height-22, 22, 22)];
    icLife.image = [UIImage imageNamed:@"ic_life"];
    [viewLife addSubview:icLife];
    
    DWTagList *lifeTag = [[DWTagList alloc] initWithFrame:CGRectMake(offsets.width, bgLife.frame.origin.y+bgLife.frame.size.height+offsets.height, 300.0f, 50.0f)];
    lifeTag.tag = 4;
    [lifeTag setAutomaticResize:YES];
    [lifeTag setBorderColor:colorLife];
    lifeTag.highlightedBackgroundColor = [UIColor colorWithRed:0.164706 green:0.541176 blue:0.858824 alpha:0.7];
    NSArray *arrayLife = [[NSArray alloc] initWithObjects:@"美容美体", @"美甲美脚", @"美发", @"瑜伽/舞蹈", nil];
    [lifeTag setTags:arrayLife];
    [lifeTag setTagDelegate:self];
    [contentView addSubview:lifeTag];
    
#pragma mark --- 购物
    UIImageView *bgShopping = [[UIImageView alloc]initWithFrame:CGRectMake(offsets.width, lifeTag.frame.origin.y+lifeTag.frame.size.height+offsets.height, 300*0.65, 88)];
    bgShopping.image = [UIImage imageNamed:@"banner_shopping"];
    [contentView addSubview:bgShopping];
    
    UIColor *colorShopping = [UIColor colorWithRed:0.164706 green:0.541176 blue:0.858824 alpha:1];
    
    UIView *viewShopping = [[UIView alloc]initWithFrame:CGRectMake(offsets.width+bgShopping.frame.size.width+offsets.width, bgShopping.frame.origin.y, 300*0.35-offsets.width, 88)];
    viewShopping.backgroundColor = colorShopping;
    [contentView addSubview:viewShopping];
    
    UILabel *labelShopping = [[UILabel alloc]initWithFrame:CGRectMake(offsets.width, offsets.height, viewShopping.frame.size.width-offsets.width*2, 21)];
    labelShopping.text = @"购物";
    labelShopping.backgroundColor = [UIColor clearColor];
    labelShopping.textColor = [UIColor whiteColor];
    labelShopping.font = [UIFont boldSystemFontOfSize:15];
    [viewShopping addSubview:labelShopping];
    
    UIImageView *icShopping = [[UIImageView alloc]initWithFrame:CGRectMake(viewShopping.frame.size.width-offsets.width-22, viewShopping.frame.size.height-offsets.height-22, 22, 22)];
    icShopping.image = [UIImage imageNamed:@"ic_shopping"];
    [viewShopping addSubview:icShopping];
    
    DWTagList *tagShopping = [[DWTagList alloc] initWithFrame:CGRectMake(offsets.width, bgShopping.frame.origin.y+bgShopping.frame.size.height+offsets.height, 300.0f, 50.0f)];
    tagShopping.tag = 5;
    [tagShopping setAutomaticResize:YES];
    [tagShopping setBorderColor:colorLife];
    tagShopping.highlightedBackgroundColor = [UIColor colorWithRed:0.164706 green:0.541176 blue:0.858824 alpha:0.7];
    NSArray *arrayShopping = [[NSArray alloc] initWithObjects:@"美容美体", @"美甲美脚", @"美发", @"瑜伽/舞蹈", nil];
    [tagShopping setTags:arrayShopping];
    [tagShopping setTagDelegate:self];
    [contentView addSubview:tagShopping];
    
#pragma mark ---
    
    [contentView setContentSize:CGSizeMake(self.view.frame.size.width, tagShopping.frame.size.height+tagShopping.frame.origin.y+10)];
    
}

- (void)loadData {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - DWTagListDelegate
- (void)selectedTag:(NSString *)tagName tag:(NSInteger)tag {
    DLog(@"tag:%d;%@", tag, tagName);
    SaleViewController *saleView = [[SaleViewController alloc]init];
    saleView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:saleView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
