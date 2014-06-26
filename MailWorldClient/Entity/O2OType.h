//
//  O2OType.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface O2OType : NSObject

@property (nonatomic, assign) NSInteger businessState;
@property (nonatomic, assign) NSInteger businessDictLevel;
@property (nonatomic, strong) NSString *businessDictId;
@property (nonatomic, strong) NSString *businessDictName;
@property (nonatomic, strong) NSString *businessDictType;
@property (nonatomic, strong) NSString *businessBranch;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
