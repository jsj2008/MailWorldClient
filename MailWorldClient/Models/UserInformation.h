//
//  UserInformation.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-14.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

@property (nonatomic, assign) NSString *userid;
@property (nonatomic, assign) NSInteger userfrom;
@property (nonatomic, strong) NSString *usermobile;
@property (nonatomic, assign) NSInteger usersex;
@property (nonatomic, strong) NSString *userbgimg;
@property (nonatomic, strong) NSString *userbirth;
@property (nonatomic, assign) NSString *userheadimg;
@property (nonatomic, strong) NSString *username;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
