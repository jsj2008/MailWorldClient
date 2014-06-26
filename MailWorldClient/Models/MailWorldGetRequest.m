//
//  MailWorldGetRequest.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-25.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailWorldGetRequest.h"

@implementation MailWorldGetRequest

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

+ (void)requestWithParams:(NSDictionary *)params andBlock:(void (^)(MailWorldGetRequest *respond, NSError *error))block {
    DLog(@"params:%@", params);
    
//    AFHTTPClient *mClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
//    
//    [mClient getPath:SERVICE_URL parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject) {
//        NSString *charlieSendString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//         DLog(@"response description:%@", charlieSendString);
//        
//     } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//         DLog(@"error description:%@",[error description]);
//     }];
    //
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:SERVICE_URL
                                                      parameters:params];
    
    AFJSONRequestOperation *aj_operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"requestWithParams:%@", JSON);
        MailWorldGetRequest *tempDto = [[MailWorldGetRequest alloc]initWithAttributes:JSON];
        
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
