//
//  O2OType.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-24.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "O2OType.h"

@implementation O2OType

@synthesize businessState;
@synthesize businessDictLevel;
@synthesize businessDictId;
@synthesize businessDictName;
@synthesize businessDictType;
@synthesize businessBranch;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    businessState = [[attributes valueForKey:@"businessState"]integerValue];
    businessDictLevel = [[attributes valueForKey:@"businessDictLevel"]integerValue];
    businessDictId = [attributes valueForKey:@"businessDictId"];
    businessDictName = [attributes valueForKey:@"businessDictName"];
    businessDictType = [attributes valueForKey:@"businessDictType"];
    businessBranch = [attributes valueForKey:@"businessBranch"];
    
    return self;
}

@end
