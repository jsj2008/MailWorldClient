//
//  MailWorldGetRequest.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-25.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LIObject.h"

@interface MailWorldGetRequest : LIObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString *error_msg;
@property (nonatomic, strong) NSDictionary *respondData;
@property (nonatomic, strong) NSArray *respondArray;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)requestWithParams:(NSDictionary *)params andBlock:(void (^)(MailWorldGetRequest *respond, NSError *error))block;

@end
