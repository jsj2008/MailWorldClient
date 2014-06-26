//
//  MaowustorePost.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-13.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MaowustorePost.h"

@implementation MaowustorePost

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
        DLog(@"error:%@", error_msg);
        resData = nil;
    }
    return self;
}

+ (void)getMaowustoreWithOrdertype:(NSInteger)ordertype currentpage:(NSInteger)currentpage pagesize:(NSInteger)pagesize xpoint:(NSString *)xpoint ypoint:(NSString *)ypoint andBlock:(void (^)(MaowustorePost *post, NSError *error))block {
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"shoplist",                           @"reqtype",
                         [NSNumber numberWithInt:ordertype],    @"ordertype",
                         [NSNumber numberWithInt:currentpage],  @"currentpage",
                         [NSNumber numberWithInt:pagesize],     @"pagesize",
                         xpoint,                                @"xpoint",
                         ypoint,                                @"ypoint",
                         nil];
    
    NSMutableURLRequest *postrequest = [AFPostAPIClient requestWithURL:SERVICE_URL andData:dic];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        DLog(@"getMaowustoreWithLocaInfo:%@", JSON);
        MaowustorePost *tempDto = [[MaowustorePost alloc]initWithAttributes:JSON];
        
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
