//
//  MaowustorePost.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//  猫屋门店接口

#import "LIObject.h"

@interface MaowustorePost : LIObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString *error_msg;
@property (nonatomic, strong) NSMutableArray *resData;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)getMaowustoreWithOrdertype:(NSInteger)ordertype currentpage:(NSInteger)currentpage pagesize:(NSInteger)pagesize xpoint:(NSString *)xpoint ypoint:(NSString *)ypoint andBlock:(void (^)(MaowustorePost *post, NSError *error))block;

@end
