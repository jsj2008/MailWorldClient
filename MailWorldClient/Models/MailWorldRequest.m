//
//  MailWorldRequest.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-14.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailWorldRequest.h"

@implementation MailWorldRequest

@synthesize result;
@synthesize error_msg;
@synthesize respondData;
@synthesize respondArray;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    result = [[attributes valueForKey:@"result"]integerValue];
    
    if (result == 1) {
        if ([[attributes valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = [attributes valueForKey:@"data"];
            respondArray = data;
        }
        else if ([[attributes valueForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = [attributes valueForKey:@"data"];
            respondData = data;
        }
        
    }
    else {
        error_msg = [attributes valueForKey:@"error_msg"];
        DLog(@"error:%@", error_msg);
        respondData = nil;
    }
    
    return self;
}

+ (void)requestWithParams:(NSDictionary *)params andBlock:(void (^)(MailWorldRequest *respond, NSError *error))block {
    DLog(@"params:%@", params);
    NSMutableURLRequest *postrequest = [AFPostAPIClient requestWithURL:SERVICE_URL andData:params];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"requestWithParams:%@", JSON);
        MailWorldRequest *tempDto = [[MailWorldRequest alloc]initWithAttributes:JSON];
        
        if (block) {
            block(tempDto, nil);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            DLog(@"error:%@", error);
            block(nil, error);
        }
    }];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    aj_operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    
    [aj_operation start];
    
//    NSString *param = [MailWorldRequest encodeDictionary:params];
//    NSString *url = [NSString stringWithFormat:@"%@%@", SERVICE_URL, param];
//
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:url
//                                                      parameters:nil];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
////    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"requestWithParams:%@", [NSString stringWithUTF8String:responseObject]);
//        
//        MailWorldRequest *tempDto = [[MailWorldRequest alloc]initWithAttributes:responseObject];
//        
//        if (block) {
//            block(tempDto, nil);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (block) {
//            DLog(@"error:%@", error);
//            block(nil, error);
//        }
//    }];
//    [operation start];
    
    
}

+ (NSString *)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        if ([[dictionary objectForKey:key]isKindOfClass:[NSNumber class]]) {
            NSInteger numberValue = [[dictionary objectForKey:key]integerValue];
            
            NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *part = [NSString stringWithFormat: @"%@=%d", encodedKey, numberValue];
            [parts addObject:part];
        }
        else if ([[dictionary objectForKey:key]isKindOfClass:[NSString class]]) {
            NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
            [parts addObject:part];
        }
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    DLog(@"encodedDictionary:%@", encodedDictionary);
    
    return encodedDictionary;
}

@end
