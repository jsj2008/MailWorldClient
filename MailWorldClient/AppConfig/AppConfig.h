//
//  AppConfig.h
//  Healthaides
//
//  Created by liyoro on 13-6-27.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UMENG_APPKEY @"5240f1f356240b08490ed376"
#define APP_CHANNEL @"Appstore"

#define BAIDU_APPKEY @"6f6d56910855714aa684ffba975b971a"

#define SERVICE_URL @"http://app.mailworld.org/maowuapp?"

#define MAOWU_APP_URL @""

//用户登录
#define URL_LOGIN @"login.php?"

//用户userid
#define KEY_USER_ID @"userid"

//是否已经登录
#define KEY_IS_LOGIN @"is_login"
//用户id
#define KEY_ID @"id"
//用户名
#define KEY_USER_NAME @"user_name"
//手机号
#define KEY_USER_PHONE @"key_user_phone"

#define KEY_LAT @"key_latitude"
#define KEY_LONG @"key_longitude"

#define kOrangeColor [UIColor colorWithRed:1.000000 green:0.505882 blue:0.235294 alpha:1]
#define kCell_SELECT_COLOR [UIColor colorWithRed:1.000000 green:0.564706 blue:0.270588 alpha:0.8]

//身边打折提醒是否打开
#define kDiscountAlert @"key_discount_alert"

//时节养生提醒是否打开
#define kSeasonRegimenAlert @"key_season_regiment_alert"

//站内公告是否打开
#define kAnnounceAlert @"key_announce_alert"

//定位所在城市
#define kLocation @"key_location"
#define KEY_LATITUDE @"key_latitude"
#define KEY_LONGITUDE @"key_longitude"

//天气相关参数
#define kWeather @"key_weather"  //天气
#define kTemp @"key_temp"       //温度

@interface AppConfig : NSObject

+ (void)clearLogin;
+ (NSString *)phone;

@end
