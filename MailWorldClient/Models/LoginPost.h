//
//  LoginPost.h
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LIObject.h"

@class UserInformation;

@interface LoginPost : LIObject

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, strong) NSString *error_msg;
@property (nonatomic, strong) NSMutableArray *resData;
@property (nonatomic, strong) UserInformation *userInfor;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password withBlock:(void (^)(LoginPost *post, NSError *error))block;

@end
