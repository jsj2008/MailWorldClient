//
//  RegisterPost.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-10.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "RegisterPost.h"

@implementation RegisterPost

@synthesize result;
@synthesize error_msg;
@synthesize resData;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    result = [[attributes valueForKey:@"result"]integerValue];
    
    if (result == 1) {
        
    }
    else {
        error_msg = [attributes valueForKey:@"error_msg"];
        NSLog(@"error:%@", error_msg);
        resData = nil;
    }
    return self;
}

+ (void)registerWithPhone:(NSString *)phone andBlock:(void (^)(RegisterPost *post, NSError *error))block {
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"reg",    @"reqtype",
                         phone,     @"userMoblie",
                         nil];
    
    NSMutableURLRequest *postrequest = [AFPostAPIClient requestWithURL:SERVICE_URL andData:dic];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        DLog(@"registerWithPhone:%@", JSON);
        
        RegisterPost *tempDto = [[RegisterPost alloc]initWithAttributes:JSON];
        
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

+ (void)validateWithPhone:(NSString *)phone verCode:(NSString *)verCode andBlock:(void (^)(BOOL post, NSError *error))block {
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"validation",    @"reqtype",
                         verCode,          @"verCode",
                         phone,            @"userMoblie",
                         nil];
    NSMutableURLRequest *postrequest = [AFPostAPIClient requestWithURL:SERVICE_URL andData:dic];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        DLog(@"validateWithPhone:%@", JSON);
        
        NSInteger result = [[JSON valueForKey:@"result"]integerValue];
        BOOL res = result==1?YES:NO;
        
        if (block) {
            block(res, nil);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            NSLog(@"error:%@", error);
            block(NO, error);
        }
    }];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    aj_operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    
    [aj_operation start];
}

@end
