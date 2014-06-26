//
//  O2oGoodQuery.h
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface O2oGoodQuery : NSObject

@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *good_area;
@property (nonatomic, strong) NSString *good_discrib;
@property (nonatomic, assign) NSInteger good_id;
@property (nonatomic, strong) NSString *good_log_url;
@property (nonatomic, strong) NSString *good_name;
@property (nonatomic, assign) NSInteger good_o2o_type;
@property (nonatomic, strong) NSString *good_origin_price;
@property (nonatomic, strong) NSString *good_pric;
@property (nonatomic, strong) NSString *good_standart;
@property (nonatomic, strong) NSString *good_type;
@property (nonatomic, assign) NSInteger merchant_id;
@property (nonatomic, strong) NSString *merchant_name;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
