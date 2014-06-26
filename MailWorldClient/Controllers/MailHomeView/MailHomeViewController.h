//
//  MailHomeViewController.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-6.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"
#import "Tools.h"
#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLGeocoder.h>
#import <ZXingWidgetController.h>
#import "MailWorldRequest.h"

@interface MailHomeViewController : UIViewController <CLLocationManagerDelegate, ZXingDelegate> {
    CLLocationManager *locationManager;
    CLGeocoder *myGecoder;

    NSString *weatherString;
    
    NSString *cityNumber;
    NSString * string2;//城市号码
    
    NSString *name22;
    NSString *number22;
    NSString *cityName22;
    
}

@property (nonatomic, strong) IBOutlet UIScrollView *contentView;

- (void)loadSearchView;
- (void)loadAdView;
- (void)loadHomeItemsView;

- (IBAction)view1Click:(id)sender;
- (IBAction)view2Click:(id)sender;
- (IBAction)view3Click:(id)sender;
- (IBAction)view4Click:(id)sender;
- (IBAction)view5Click:(id)sender;
- (IBAction)view6Click:(id)sender;
- (IBAction)view7Click:(id)sender;
- (IBAction)view8Click:(id)sender;

//获取天气
- (void)getWeatherWithCity:(NSString *)paramCity;
//加载天气相关图片
- (void)loadWeatherImage;
//加载节气相关图片
- (void)loadSolarImage;

@end
