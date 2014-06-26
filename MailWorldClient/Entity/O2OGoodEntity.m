//
//  O2OGoodEntity.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "O2OGoodEntity.h"

@implementation O2OGoodEntity

@synthesize good_id;
@synthesize good_log_url;
@synthesize good_name;
@synthesize good_discrib;
@synthesize good_origin_price;
@synthesize good_price;
@synthesize zhekou;


- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    good_id = [attributes valueForKey:@"good_id"];
    good_log_url = [attributes valueForKey:@"good_log_url"];
    good_name = [attributes valueForKey:@"good_name"];
    good_discrib = [attributes valueForKey:@"good_discrib"];
    good_origin_price = [attributes valueForKey:@"good_origin_price"];
    good_price = [attributes valueForKey:@"good_price"];
    zhekou = [attributes valueForKey:@"zhekou"];
    
    return self;
}

@end
