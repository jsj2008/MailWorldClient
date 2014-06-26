//
//  DiscountsShopEntity.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "DiscountsShopEntity.h"

@implementation DiscountsShopEntity

@synthesize hdid;
@synthesize shopid;
@synthesize shopname;
@synthesize hdname;
@synthesize oldprice;
@synthesize hdprice;
@synthesize begantime;
@synthesize endtime;
@synthesize xpoint;
@synthesize ypoint;
@synthesize hdimg;
@synthesize pagecount;
@synthesize distance;
@synthesize hdcontent;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    hdid = [[attributes valueForKey:@"hdid"]integerValue];
    shopid = [[attributes valueForKey:@"result"]integerValue];
    shopname = [attributes valueForKey:@"shopname"];
    hdname = [attributes valueForKey:@"hdname"];
    oldprice = [attributes valueForKey:@"oldprice"];
    hdprice = [attributes valueForKey:@"hdprice"];
    begantime = [attributes valueForKey:@"begantime"];
    endtime = [attributes valueForKey:@"endtime"];
    xpoint = [attributes valueForKey:@"xpoint"];
    ypoint = [attributes valueForKey:@"ypoint"];
    pagecount = [[attributes valueForKey:@"pagecount"]integerValue];
    
    return self;
}

@end
