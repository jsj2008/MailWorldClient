//
//  O2OGoodEntity.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface O2OGoodEntity : NSObject

@property (nonatomic, strong) NSString *good_id;
@property (nonatomic, strong) NSString *good_log_url;
@property (nonatomic, strong) NSString *good_name;
@property (nonatomic, strong) NSString *good_discrib;
@property (nonatomic, strong) NSString *good_origin_price;
@property (nonatomic, strong) NSString *good_price;
@property (nonatomic, strong) NSString *zhekou;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
