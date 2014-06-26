//
//  ShopEntity.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-15.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "ShopEntity.h"

@implementation ShopEntity

@synthesize shopid;
@synthesize shopname;
@synthesize shopAddress;
@synthesize shopgrad;
@synthesize shopzhuying;
@synthesize shopmwserver;
@synthesize xpoint;
@synthesize ypoint;
@synthesize pagecount;
@synthesize distance;
@synthesize shopImage;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    shopid = [[attributes valueForKey:@"result"]integerValue];
    shopname = [attributes valueForKey:@"shopname"];
    shopAddress = [attributes valueForKey:@"shopAddress"];
    shopgrad = [[attributes valueForKey:@"shopgrad"]integerValue];
    shopzhuying = [attributes valueForKey:@"shopzhuying"];
    shopmwserver = [attributes valueForKey:@"shopmwserver"];
    xpoint = [attributes valueForKey:@"xpoint"];
    ypoint = [attributes valueForKey:@"ypoint"];
    pagecount = [[attributes valueForKey:@"pagecount"]integerValue];
    
    return self;
}

@end
