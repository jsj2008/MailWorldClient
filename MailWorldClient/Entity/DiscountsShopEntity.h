//
//  DiscountsShopEntity.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//  打折活动商店

#import <Foundation/Foundation.h>

@interface DiscountsShopEntity : NSObject

@property (nonatomic, assign) NSInteger hdid;
@property (nonatomic, assign) NSInteger shopid;
@property (nonatomic, strong) NSString *shopname;
@property (nonatomic, strong) NSString *hdname;
@property (nonatomic, strong) NSString *oldprice;
@property (nonatomic, strong) NSString *hdprice;
@property (nonatomic, strong) NSString *begantime;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *xpoint;
@property (nonatomic, strong) NSString *ypoint;
@property (nonatomic, strong) NSString *hdimg;
@property (nonatomic, assign) NSInteger pagecount;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *hdcontent;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
