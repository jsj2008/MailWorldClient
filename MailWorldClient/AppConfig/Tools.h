//
//  Tools.h
//  Healthaides
//
//  Created by liyoro on 13-6-27.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOS7_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//判断用户设备是iPad还是iPhone的代码
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SOURCE_LANGUAGE_FONT_NAME @"HelveticaNeue-Light"
#define ENGLISH_TEXT_FONT DESTINATION_LANGUAGE_FONT(14)//[UIFont fontWithName:@"Courier New" size:14]
#define CHINESE_TEXT_FONT SOURCE_LANGUAGE_FONT(14)//[UIFont fontWithName:FONT_NAME size:14]
#define SOURCE_LANGUAGE_FONT(fontSize) [[Tools sharedInstance] getSourceLanguageFont:fontSize]
#define CHINESE_TITLE_FONT SOURCE_LANGUAGE_FONT(18)//[UIFont fontWithName:FONT_NAME size:18]

#define MainFrame [[UIScreen mainScreen] applicationFrame]

@interface Tools : NSObject

+ (Tools *)sharedInstance;

+ (void) saveBool:(BOOL)boolValue forKey:(NSString *)key;
+ (BOOL) boolForKey:(NSString *)key;

+ (void) saveObject:(id)objectValue forKey:(NSString *)key;
+ (id) objectForKey:(NSString *)key;
+ (NSString *) stringForKey:(NSString *)key;

+ (void) saveInteger:(NSInteger)intValue forKey:(NSString *)key;
+ (NSInteger)intForKey:(NSString *)key;

+ (void) saveDouble:(float)doubleValue forKey:(NSString *)key;
+ (float)doubleForKey:(NSString *)key;

+ (void) saveFloat:(float)floatValue forKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;

- (UIFont *)getSourceLanguageFont:(CGFloat)fontSize;

+ (BOOL)isStringNull:(NSString *)paramString;
/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile;

@end
