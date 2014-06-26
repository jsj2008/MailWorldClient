//
//  UserInformation.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-14.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//  用户信息

#import "UserInformation.h"

@implementation UserInformation

@synthesize userid;
@synthesize userfrom;
@synthesize usermobile;
@synthesize usersex;
@synthesize userbgimg;
@synthesize userbirth;
@synthesize userheadimg;
@synthesize username;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    userid = [attributes valueForKey:@"result"];
    userfrom = [[attributes valueForKey:@"userfrom"]integerValue];
    usermobile = [attributes valueForKey:@"usermobile"];
    usersex = [[attributes valueForKey:@"usersex"]integerValue];
    userbgimg = [attributes valueForKey:@"userbgimg"];
    userbirth = [attributes valueForKey:@"userbirth"];
    userheadimg = [attributes valueForKey:@"userheadimg"];
    username = [attributes valueForKey:@"username"];
    
    return self;
}

@end
