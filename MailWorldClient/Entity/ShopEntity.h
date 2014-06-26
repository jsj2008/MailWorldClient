//
//  ShopEntity.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-15.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopEntity : NSObject

@property (nonatomic, assign) NSInteger shopid;
@property (nonatomic, strong) NSString *shopname;
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, assign) NSInteger shopgrad;
@property (nonatomic, strong) NSString *shopzhuying;
@property (nonatomic, strong) NSString *shopmwserver;
@property (nonatomic, strong) NSString *xpoint;
@property (nonatomic, strong) NSString *ypoint;
@property (nonatomic, assign) NSInteger pagecount;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *shopImage;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
