//
//  AFPostAPIClient.m
//  AFNetworking iOS Example
//
//  Created by liyoro on 13-4-10.
//  Copyright (c) 2013年 Gowalla. All rights reserved.
//

#import "AFPostAPIClient.h"

@implementation AFPostAPIClient

+ (AFPostAPIClient *)requestWithURL:(NSString *)paramURL andData:(NSDictionary *)paramDictionary {
    static AFPostAPIClient *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFPostAPIClient alloc]initWithURL:[NSURL URLWithString:paramURL] data:paramDictionary];
//    });
    
    return _sharedClient;
}

- (id)initWithURL:(NSURL *)URL data:(NSDictionary *)paramDictionary {
    
    self = [super initWithURL:URL];
    if (!self) {
        return nil;
    }
//    NSLog(@"url:%@", URL);
    
//    NSError *error;
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:paramDictionary
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
    
    NSData *postData = [self encodeDictionary:paramDictionary];
    
    NSLog(@"s:%@%@", URL, [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding]);
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    [self setURL:URL];
    [self setHTTPMethod:@"POST"];
    [self setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPBody:postData];
    
    return self;
}

+ (AFPostAPIClient *)requestWithURL:(NSString *)paramURL andMutableData:(NSMutableDictionary *)paramDictionary {
    static AFPostAPIClient *_sharedClient = nil;
    _sharedClient = [[AFPostAPIClient alloc]initWithURL:[NSURL URLWithString:paramURL] mutabledata:paramDictionary];
    
    return _sharedClient;
}

- (id)initWithURL:(NSURL *)URL mutabledata:(NSMutableDictionary *)paramDictionary {
    
    self = [super initWithURL:URL];
    if (!self) {
        return nil;
    }
    //    NSLog(@"url:%@", URL);
    
    NSError *error;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:paramDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *postString = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"s2:%@%@", URL, postString);
    
//    NSString *paramObject = [NSString stringWithFormat:@"[%@]", postString];
//    NSLog(@"paramObject:%@", paramObject);
    
//    NSData *postData2 = [paramObject dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString *postString2 = [[NSString alloc]initWithData:postData2 encoding:NSUTF8StringEncoding];
//    NSLog(@"s2:%@%@", URL, postString2);
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    [self setURL:URL];
    [self setHTTPMethod:@"POST"];
    [self setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPBody:postData];
    
    return self;
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
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
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

@end
