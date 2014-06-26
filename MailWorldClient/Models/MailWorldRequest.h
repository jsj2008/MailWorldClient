//
//  MailWorldRequest.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-14.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//  通用网络请求
/**
 *
 * @param params
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                                @"value",   @"reqtype",
                                                @"value",   @"key",
                                                @"value",   @"key",
                                                nil];
 *
 *  @param nonatomic
 *  @param assign
 *
 *  @return 
 */
#import "LIObject.h"

@interface MailWorldRequest : LIObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString *error_msg;
@property (nonatomic, strong) NSDictionary *respondData;
@property (nonatomic, strong) NSArray *respondArray;

- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)requestWithParams:(NSDictionary *)params andBlock:(void (^)(MailWorldRequest *respond, NSError *error))block;

@end
