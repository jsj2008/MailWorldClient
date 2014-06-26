//
//  RegisterPost.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-10.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LIObject.h"

@interface RegisterPost : LIObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString *error_msg;
@property (nonatomic, strong) NSMutableArray *resData;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)registerWithPhone:(NSString *)phone andBlock:(void (^)(RegisterPost *post, NSError *error))block;
+ (void)validateWithPhone:(NSString *)phone verCode:(NSString *)verCode andBlock:(void (^)(BOOL post, NSError *error))block;

@end
