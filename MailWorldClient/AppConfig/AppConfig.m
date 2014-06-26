//
//  AppConfig.m
//  Healthaides
//
//  Created by liyoro on 13-6-27.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "AppConfig.h"
#import "Tools.h"

@implementation AppConfig

+ (void)clearLogin {
    [Tools saveBool:NO forKey:KEY_IS_LOGIN];
    [Tools saveObject:nil forKey:KEY_USER_ID];
    [Tools saveObject:nil forKey:KEY_USER_NAME];
}

+ (NSString *)phone {
    return [Tools stringForKey:KEY_USER_PHONE];
}

@end
