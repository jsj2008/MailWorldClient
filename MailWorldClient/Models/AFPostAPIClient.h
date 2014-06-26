//
//  AFPostAPIClient.h
//  AFNetworking iOS Example
//
//  Created by liyoro on 13-4-10.
//  Copyright (c) 2013年 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFPostAPIClient : NSMutableURLRequest

+ (AFPostAPIClient *)requestWithURL:(NSString *)paramURL andData:(NSDictionary *)paramDictionary;
- (id)initWithURL:(NSURL *)URL data:(NSDictionary *)paramDictionary;

+ (AFPostAPIClient *)requestWithURL:(NSString *)paramURL andMutableData:(NSMutableDictionary *)paramDictionary;
- (id)initWithURL:(NSURL *)URL mutabledata:(NSMutableDictionary *)paramDictionary;

@end
