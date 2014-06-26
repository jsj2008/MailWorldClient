//
//  MailHomeViewController.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-6.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "MailHomeViewController.h"

#import "LIUITextField.h"

#import "IntroControll.h"
#import "IntroView.h"

#import "MailHouseViewController.h"
#import "O2OViewController.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

#import <QRCodeReader.h>

//邻家男孩
#import "StoreViewController.h"

#define kSpacing 4.0
#define kAdViewHeigh 160.0

@interface MailHomeViewController () <UITextFieldDelegate> {
    LIUITextField *searchField;
    //遮罩层
    UIView *maskLayer;
    
    UIView *searchView;
    IntroControll *adView;
    UIView *view8;
    
    UILabel *labelCity;
    UILabel *labelWeather;
    UILabel *labelTemp;
    UIImageView *imageWeather;
    
    EMAsyncImageView *imageViewWeather;
}

@end

@implementation MailHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //delegate
    locationManager.delegate = self;
    //The desired location accuracy.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //Specifies the minimum update distance in meters.
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.distanceFilter = 1000.0f;
}

-(void)viewWillDisappear:(BOOL)animated {
    locationManager = nil;
    locationManager.delegate = nil; // 不用时，置nil
}

- (void)loadSearchView {
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    searchView.backgroundColor = [UIColor colorWithRed:0.901961 green:0.901961 blue:0.901961 alpha:1];
    
    searchField = [[LIUITextField alloc]initWithFrame:CGRectMake(10, 8, 258, 34) cornerRadius:0.0];
    searchField.placeholder = @"请输入搜索关键字";
    searchField.delegate = self;
    [searchView addSubview:searchField];
    
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSearch setFrame:CGRectMake(searchField.frame.origin.x+searchField.frame.size.width+8, 8, 34, 34)];
    [btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [btnSearch setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchView addSubview:btnSearch];
    
    [self.contentView addSubview:searchView];
}

- (void)loadAdView {
    
    CGFloat kWith = 320 - 2*kSpacing;
    
    IntroView *view1 = [[IntroView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAdViewHeigh)];
    
    imageViewWeather = [[EMAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, view1.frame.size.height)];
    imageViewWeather.image = [UIImage imageNamed:@"banner"];
//    imageView1.imageUrl = @"http://t-1.tuzhan.com/e10068f6f7d1/p-1/l/2012/09/22/11/af50d5dfc8184e1390843575fd645643.png";
    [view1 addSubview:imageViewWeather];
    
    labelCity = [[UILabel alloc]initWithFrame:CGRectMake(48, 50, 100, 21)];
    labelCity.backgroundColor = [UIColor clearColor];
    labelCity.textColor = [UIColor whiteColor];
    labelCity.font = [UIFont boldSystemFontOfSize:23];
    [view1 addSubview:labelCity];
    
    CGFloat imageWidth = 68.0;
    
    labelWeather = [[UILabel alloc]initWithFrame:CGRectMake(imageWidth+20+8, labelCity.frame.origin.y+labelCity.frame.size.height+4, 100, 21)];
    labelWeather.backgroundColor = [UIColor clearColor];
    labelWeather.textColor = [UIColor whiteColor];
    labelWeather.font = [UIFont boldSystemFontOfSize:15];
    [view1 addSubview:labelWeather];
    
    labelTemp = [[UILabel alloc]initWithFrame:CGRectMake(labelWeather.frame.origin.x, labelWeather.frame.origin.y+labelWeather.frame.size.height+4, 100, 21)];
    labelTemp.backgroundColor = [UIColor clearColor];
    labelTemp.textColor = [UIColor whiteColor];
    labelTemp.font = [UIFont boldSystemFontOfSize:16];
    [view1 addSubview:labelTemp];
    
    CGFloat imageHight = labelWeather.frame.size.height+labelTemp.frame.size.height;
    
    imageWeather = [[UIImageView alloc]initWithFrame:CGRectMake(20, labelCity.frame.origin.y+labelCity.frame.size.height+8, imageWidth, imageHight)];
    [view1 addSubview:imageWeather];
    
    IntroView *view2 = [[IntroView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAdViewHeigh)];
    
    EMAsyncImageView *imageView2 = [[EMAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height)];
    imageView2.image = [UIImage imageNamed:@"banner"];
//    imageView2.imageUrl = @"http://t-1.tuzhan.com/2406f5d394f6/p-1/l/2012/09/21/18/69d61c47c3e14998bacbaa2a4df74d5d.png";
    [view2 addSubview:imageView2];
    
    IntroView *view3 = [[IntroView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAdViewHeigh)];
    
    EMAsyncImageView *imageView3 = [[EMAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, view3.frame.size.width, view3.frame.size.height)];
    imageView3.image = [UIImage imageNamed:@"banner"];
//    imageView3.imageUrl = @"http://t-1.tuzhan.com/061197b1b7b4/p-2/l/2012/09/17/20/64616ff31bb4495cad5aa7c65696d32b.png";
    [view3 addSubview:imageView3];
    
    adView = [[IntroControll alloc] initWithFrame:CGRectMake(kSpacing, searchView.frame.origin.y+searchView.frame.size.height+8, kWith, kAdViewHeigh) pages:@[view1, view2, view3]];
    
    [self.contentView addSubview:adView];
}

- (void)loadHomeItemsView {
    CGFloat kWith = 320 - 2*kSpacing;
    CGFloat lWith = kWith*0.65;
    CGFloat sWith = kWith-lWith-kSpacing;
    CGFloat hWith = (kWith-kSpacing)/2;
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(kSpacing, adView.frame.origin.y+adView.frame.size.height+8, lWith, sWith)];
    view1.backgroundColor = [UIColor colorWithRed:0.937255 green:0.321569 blue:0.129412 alpha:1];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, view1.frame.size.height/2-48/2, 48, 48)];
    imageView1.image = [UIImage imageNamed:@"ic_neightbor"];
    [view1 addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(
                                                               imageView1.frame.origin.x+imageView1.frame.size.width+8,
                                                               view1.frame.size.height/2-21/2,
                                                               view1.frame.size.width-8-imageView1.frame.size.width-8,
                                                               21)];
    label1.text = @"猫屋--我的邻家男孩";
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:14];
    [view1 addSubview:label1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 0, lWith, sWith)];
    [btn1 addTarget:self action:@selector(view1Click:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn1];
    
    [self.contentView addSubview:view1];
    
#pragma mark - O2O
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(view1.frame.origin.x+view1.frame.size.width+kSpacing, view1.frame.origin.y, sWith, sWith)];
    view2.backgroundColor = [UIColor colorWithRed:0.000000 green:0.741176 blue:0.764706 alpha:1];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-30, view2.frame.size.height/2-30, 60, 60)];
    imageView2.image = [UIImage imageNamed:@"ic_o2o"];
    [view2 addSubview:imageView2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view2.frame.size.width-20, 21)];
    label2.text = @"O2O";
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont boldSystemFontOfSize:15];
    [view2 addSubview:label2];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(0, 0, sWith, sWith)];
    [btn2 addTarget:self action:@selector(view2Click:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:btn2];
    
    [self.contentView addSubview:view2];
    
#pragma mark - 扫扫
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(kSpacing, view1.frame.origin.y + view1.frame.size.height+kSpacing, sWith, sWith)];
    view3.backgroundColor = [UIColor colorWithRed:1.000000 green:0.662745 blue:0.235294 alpha:1];
    
    CGFloat imageView3Width = 80.0;
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-imageView3Width/2, view3.frame.size.height/2-imageView3Width/2, imageView3Width, imageView3Width)];
    imageView3.image = [UIImage imageNamed:@"ic_Sweep"];
    [view3 addSubview:imageView3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view3.frame.size.width-20, 21)];
    label3.text = @"扫扫";
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont boldSystemFontOfSize:15];
    [view3 addSubview:label3];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake(0, 0, sWith, sWith)];
    [btn3 addTarget:self action:@selector(view3Click:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn3];
    
    [self.contentView addSubview:view3];
    
#pragma mark - 喵喵-我的小屋
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(view3.frame.origin.x+view3.frame.size.width+kSpacing, view3.frame.origin.y, lWith, sWith)];
    view4.backgroundColor = [UIColor colorWithRed:0.192157 green:0.549020 blue:0.776471 alpha:1];
    
    CGFloat imageView4Width = 60.0;
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-imageView4Width/2, view4.frame.size.height/2-imageView4Width/2, imageView4Width, imageView4Width)];
    imageView4.image = [UIImage imageNamed:@"ic_my_house"];
    [view4 addSubview:imageView4];
    
    UIImageView *imageView4_2 = [[UIImageView alloc]initWithFrame:CGRectMake(view4.frame.size.width-imageView4Width-8, view4.frame.size.height-imageView4Width-8, imageView4Width, imageView4Width)];
    imageView4_2.image = [UIImage imageNamed:@"ic_manage_logo"];
    [view4 addSubview:imageView4_2];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view4.frame.size.width-20, 21)];
    label4.text = @"喵喵-我的小屋";
    label4.backgroundColor = [UIColor clearColor];
    label4.textColor = [UIColor whiteColor];
    label4.font = [UIFont boldSystemFontOfSize:15];
    [view4 addSubview:label4];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(0, 0, lWith, sWith)];
    [btn4 addTarget:self action:@selector(view4Click:) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:btn4];
    
    [self.contentView addSubview:view4];
    
#pragma mark - 天气通
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(kSpacing, view3.frame.origin.y+view3.frame.size.height+kSpacing, lWith, sWith+30)];
    view5.backgroundColor = [UIColor colorWithRed:0.631373 green:0.321569 blue:0.678431 alpha:1];
    
    CGFloat imageView5Width = 80.0;
    
    UIImageView *imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(view5.frame.size.width/2-imageView5Width/2, view5.frame.size.height/2-imageView5Width/2, imageView5Width, imageView5Width)];
    imageView5.image = [UIImage imageNamed:@"ic_weather"];
    [view5 addSubview:imageView5];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view5.frame.size.width-20, 21)];
    label5.text = @"天气通";
    label5.backgroundColor = [UIColor clearColor];
    label5.textColor = [UIColor whiteColor];
    label5.font = [UIFont boldSystemFontOfSize:15];
    [view5 addSubview:label5];
    
    [self.contentView addSubview:view5];
    
#pragma mark - 公交行
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(view5.frame.origin.x+view5.frame.size.width+kSpacing, view5.frame.origin.y, sWith, sWith+30)];
    view6.backgroundColor = [UIColor colorWithRed:0.505882 green:0.674510 blue:0.215686 alpha:1];
    
    CGFloat imageView6Width = 80.0;
    
    UIImageView *imageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(view6.frame.size.width/2-imageView6Width/2, view6.frame.size.height/2-imageView6Width/2, imageView6Width, imageView6Width)];
    imageView6.image = [UIImage imageNamed:@"ic_bus"];
    [view6 addSubview:imageView6];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view6.frame.size.width-20, 21)];
    label6.text = @"公交行";
    label6.backgroundColor = [UIColor clearColor];
    label6.textColor = [UIColor whiteColor];
    label6.font = [UIFont boldSystemFontOfSize:15];
    [view6 addSubview:label6];
    
    [self.contentView addSubview:view6];
    
#pragma mark - 生活禅
    UIView *view7 = [[UIView alloc]initWithFrame:CGRectMake(kSpacing, view6.frame.origin.y+view6.frame.size.height+kSpacing, hWith, hWith)];
    view7.backgroundColor = [UIColor colorWithRed:0.694118 green:0.596078 blue:0.427451 alpha:1];
    
    CGFloat imageView7Width = 80.0;
    
    UIImageView *imageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(view7.frame.size.width/2-imageView7Width/2, view7.frame.size.height/2-imageView7Width/2, imageView7Width, imageView7Width)];
    imageView7.image = [UIImage imageNamed:@"ic_zen_living"];
    [view7 addSubview:imageView7];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view7.frame.size.width-20, 21)];
    label7.text = @"生活禅";
    label7.backgroundColor = [UIColor clearColor];
    label7.textColor = [UIColor whiteColor];
    label7.font = [UIFont boldSystemFontOfSize:15];
    [view7 addSubview:label7];
    
    [self.contentView addSubview:view7];
    
#pragma mark - 友情反馈
    view8 = [[UIView alloc]initWithFrame:CGRectMake(view7.frame.origin.x+view7.frame.size.width+kSpacing, view7.frame.origin.y, hWith, hWith)];
    view8.backgroundColor = [UIColor colorWithRed:0.964706 green:0.282353 blue:0.360784 alpha:1];
    
    CGFloat imageView8Width = 80.0;
    
    UIImageView *imageView8 = [[UIImageView alloc]initWithFrame:CGRectMake(view8.frame.size.width/2-imageView8Width/2, view8.frame.size.height/2-imageView8Width/2, imageView8Width, imageView8Width)];
    imageView8.image = [UIImage imageNamed:@"ic_feedback"];
    [view8 addSubview:imageView8];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, view8.frame.size.width-20, 21)];
    label8.text = @"友情反馈";
    label8.backgroundColor = [UIColor clearColor];
    label8.textColor = [UIColor whiteColor];
    label8.font = [UIFont boldSystemFontOfSize:15];
    [view8 addSubview:label8];
    
    [self.contentView addSubview:view8];
}

//加载天气相关图片
- (void)loadWeatherImage {
    DLog(@"loadWeatherImage");
    NSDictionary *dicTianqi = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"tianqi",  @"reqtype",
                         nil];
    [MailWorldRequest requestWithParams:dicTianqi andBlock:^(MailWorldRequest *respond, NSError *error) {
        
    }];
}

//加载节气相关图片
- (void)loadSolarImage {
    DLog(@"loadSolarImage");
    NSDictionary *dicJieqi = [[NSDictionary alloc]initWithObjectsAndKeys:
                               @"jieqi",  @"reqtype",
                               nil];
    [MailWorldRequest requestWithParams:dicJieqi andBlock:^(MailWorldRequest *respond, NSError *error) {
        
    }];
}

- (IBAction)view1Click:(id)sender {
    StoreViewController *storeView = [[StoreViewController alloc]init];
    storeView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeView animated:YES];
}

- (IBAction)view2Click:(id)sender {
    O2OViewController *o2oView = [[O2OViewController alloc]init];
    o2oView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:o2oView animated:YES];
}

- (IBAction)view3Click:(id)sender {
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:NO OneDMode:NO showLicense:NO];
    widController.wantsFullScreenLayout = NO;
    widController.hidesBottomBarWhenPushed = YES;
    widController.title = @"WO扫扫";
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    [self.navigationController pushViewController:widController animated:YES];
}

- (IBAction)view4Click:(id)sender {
    
}

- (IBAction)view5Click:(id)sender {
    
}

- (IBAction)view6Click:(id)sender {
    
}

- (IBAction)view7Click:(id)sender {
    
}

- (IBAction)view8Click:(id)sender {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - 搜索条
    [self loadSearchView];
#pragma mark - end
    [self loadAdView];
    [self loadHomeItemsView];
    
    [self.contentView setContentSize:CGSizeMake(320, view8.frame.origin.y+view8.frame.size.height+10+54)];
    
    locationManager = [[CLLocationManager alloc] init]; 
    
    [self performSelectorInBackground:@selector(startLocation) withObject:nil];
//    [self performSelectorInBackground:@selector(loadWeatherImage) withObject:nil];
//    [self startLocation];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    maskLayer = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, self.view.frame.size.height-50)];
    maskLayer.backgroundColor = [UIColor blackColor];
    maskLayer.alpha = 0.5;
    [self.view addSubview:maskLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchView)];
    [maskLayer addGestureRecognizer:tap];//添加view的点击事件
}

- (void)hideSearchView {
    [searchField resignFirstResponder];
    searchField.text = @"";
    [maskLayer removeFromSuperview];
}

#pragma mark - baidumap 定位

//普通态
- (void)startLocation {
    NSLog(@"进入普通定位态");
    [locationManager startUpdatingLocation];
}

//停止定位
-(void)stopLocation {
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    DLog(@"didChangeAuthorizationStatus---%u",status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
    DLog(@"didChangeAuthorizationStatus----%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    double a = newLocation.coordinate.latitude;
    double b = newLocation.coordinate.longitude;
    
    [Tools saveObject:[NSString stringWithFormat:@"%f", a] forKey:KEY_LATITUDE];
    [Tools saveObject:[NSString stringWithFormat:@"%f", b] forKey:KEY_LONGITUDE];
    
    DLog(@"didUpdateToLocation:  newLocation: %@", newLocation);
    
    myGecoder = [[CLGeocoder alloc] init];
    [myGecoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error == nil && [placemarks count]>0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"Country = %@", placemark.country);
            NSLog(@"Postal Code = %@", placemark.postalCode);
            NSLog(@"Locality = %@", placemark.locality);
            NSLog(@"address = %@",placemark.name);
            NSLog(@"administrativeArea = %@",placemark.administrativeArea);
            NSLog(@"subAdministrativeArea = %@",placemark.subAdministrativeArea);
            NSLog(@"locality = %@", placemark.locality);
            NSLog(@"thoroughfare = %@", placemark.thoroughfare);
            
            [self performSelectorOnMainThread:@selector(getWeatherWithCity:) withObject:placemark.locality waitUntilDone:YES];
//            [self getWeatherWithCity:placemark.locality];
        }
        else if(error==nil && [placemarks count]==0){
            NSLog(@"No results were returned.");
        }
        else if(error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

//获取天气
- (void)getWeatherWithCity:(NSString *)paramCity {
    DLog(@"paramCity:%@", paramCity);
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"cityname.sqlite"];
    //        NSLog(@"  数据库地址     %@",sqlPath);
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"cityname" ofType:@"sqlite"];
    //        NSLog(@"原始地址:%@",orignFilePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            NSLog(@"open database error %@",[err localizedDescription]);
        }
        
        //            NSLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    //这个方法一定要执行
    if (![db open]) {
        NSLog(@"数据库打开失败！");
    }
    FMResultSet *resultSet=[db executeQuery:@"select * from citys"];
    while ([resultSet next]) {
        name22 = [resultSet stringForColumn:@"Name"];
        number22 = [resultSet stringForColumn:@"city_num"];
        NSArray *nameArray = [name22 componentsSeparatedByString:@"."];
        if (name22.length<5) {
            cityName22 = name22;
            
            if (NSNotFound != [paramCity rangeOfString:cityName22].location) {
                cityNumber = number22;
                NSLog(@"a");
            }
        }
        else {
            cityName22 = [nameArray objectAtIndex:1];
            
            if (NSNotFound != [paramCity rangeOfString:cityName22].location) {
                cityNumber = number22;
                NSLog(@"b");
            }
        }
    }
    NSLog(@"查找成功");
    [db close];
    
    if (cityNumber == NULL) {
        NSLog(@"NULLSSS");
        string2 = @"101280601";
    }
    else
    {
        string2 = cityNumber;
    }
    NSString * string1 = @"http://www.weather.com.cn/data/cityinfo/";
    NSString * string3 = @".html";
    weatherString = @"";
    weatherString = [weatherString stringByAppendingFormat:@"%@%@%@",string1,string2,string3];
    
    NSURL *url1 = [NSURL URLWithString:weatherString];
    NSURLRequest *request1 = [[NSURLRequest alloc]initWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:received1 options:kNilOptions error:&error];
    
    NSDictionary *weatherinfo = [json valueForKey:@"weatherinfo"];
    NSString *city = [weatherinfo valueForKey:@"city"];
    NSString *temp = [NSString stringWithFormat:@"%@/%@", [weatherinfo valueForKey:@"temp1"], [weatherinfo valueForKey:@"temp2"]];
    NSString *weather = [weatherinfo valueForKey:@"weather"];
    DLog(@"%@;%@;%@", city, temp, weather);
    
    if ([Tools isStringNull:city] == NO) {
        [Tools saveObject:city forKey:kLocation];
    }
    if ([Tools isStringNull:temp] == NO) {
        [Tools saveObject:temp forKey:kTemp];
    }
    if ([Tools isStringNull:weather] == NO) {
        [Tools saveObject:weather forKey:kWeather];
    }
    labelCity.text = [Tools stringForKey:kLocation];
    labelWeather.text = [Tools stringForKey:kWeather];
    labelTemp.text = [Tools stringForKey:kTemp];
    NSString *strWeather = [Tools stringForKey:kWeather];
    NSString *fileName = @"晴";
    
    if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雨转晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
    }
    imageWeather.image = [UIImage imageNamed:fileName];
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    [self.navigationController popViewControllerAnimated:YES];
    [self outPutResult:result];
//    [self dismissViewControllerAnimated:YES completion:^{[self outPutResult:result];}];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"cancel!");}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)outPutResult:(NSString *)result {
    DLog(@"result:%@", result);
}

@end
