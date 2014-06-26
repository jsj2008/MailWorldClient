//
//  O2oGoodQuery.m
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "O2oGoodQuery.h"

@implementation O2oGoodQuery

@synthesize add_time;
@synthesize good_area;
@synthesize good_discrib;
@synthesize good_id;
@synthesize good_log_url;
@synthesize good_name;
@synthesize good_o2o_type;
@synthesize good_origin_price;
@synthesize good_pric;
@synthesize good_standart;
@synthesize good_type;
@synthesize merchant_id;
@synthesize merchant_name;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    add_time = [attributes valueForKeyPath:@"add_time"];
    good_area = [attributes valueForKeyPath:@"good_area"];
    good_discrib = [attributes valueForKeyPath:@"good_discrib"];
    good_id = [[attributes valueForKeyPath:@"good_id"]integerValue];
    good_log_url = [attributes valueForKeyPath:@"good_log_url"];
    good_name = [attributes valueForKeyPath:@"good_name"];
    good_o2o_type = [[attributes valueForKeyPath:@"good_o2o_type"]integerValue];
    good_origin_price = [attributes valueForKeyPath:@"good_origin_price"];
    good_pric = [attributes valueForKeyPath:@"good_pric"];
    good_standart = [attributes valueForKeyPath:@"good_standart"];
    good_type = [attributes valueForKeyPath:@"good_type"];
    merchant_id = [[attributes valueForKeyPath:@"merchant_id"]integerValue];
    merchant_name = [attributes valueForKeyPath:@"merchant_name"];
    
    return self;
}

@end
