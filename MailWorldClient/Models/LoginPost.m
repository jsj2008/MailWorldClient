//
//  LoginPost.m
//  MailWorldClient
//
//  Created by liyoro on 13-9-29.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LoginPost.h"
#import "UserInformation.h"

@implementation LoginPost

@synthesize result;
@synthesize error_msg;
@synthesize resData;
@synthesize userInfor;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    result = [[attributes valueForKey:@"result"]integerValue];
    
    if (result == 1) {
        NSDictionary *data = [attributes valueForKey:@"data"];
        UserInformation *info = [[UserInformation alloc]initWithAttributes:data];
        userInfor = info;
    }
    else {
        error_msg = [attributes valueForKey:@"error_msg"];
        DLog(@"error:%@", error_msg);
        resData = nil;
    }
    
    return self;
}

+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password withBlock:(void (^)(LoginPost *post, NSError *error))block {
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"login",  @"reqtype",
                         phone,     @"userMoblie",
                         password,  @"userPass",
                         nil];
    
    NSMutableURLRequest *postrequest = [AFPostAPIClient requestWithURL:SERVICE_URL andData:dic];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        DLog(@"loginWithPhone:%@", JSON);
        LoginPost *tempDto = [[LoginPost alloc]initWithAttributes:JSON];
        
        if (block) {
            block(tempDto, nil);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        DLog(@"json:%@", error);
        if (block) {
            block(nil, error);
        }
    }];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    aj_operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    
    [aj_operation start];
}

@end
