//
//  JTLocationManager.m
//  IOS_108
//
//  Created by csctest on 16/5/30.
//  Copyright © 2016年 csctest. All rights reserved.
//

#import "JTLocationManager.h"



@interface JTLocationManager () <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder        *_geocoder;
}



@end

@implementation JTLocationManager

- (NSMutableDictionary *)gisDic
{
    if (!_gisDic) {
        _gisDic = [[NSMutableDictionary alloc] init];
    }
    return _gisDic;
}

+ (instancetype)shareLocationManager
{
    static JTLocationManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JTLocationManager alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        _geocoder=[[CLGeocoder alloc]init];
        _locationManager = [[CLLocationManager alloc] init];
        //        [self startGetLantitudeAndLongtitude];
        
    }
    return self;
}

- (void)startGetLantitudeAndLongtitude
{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        {
            [self showAlv];
            return;
        }
        CLAuthorizationStatus status=[CLLocationManager authorizationStatus];
        
        if (status==kCLAuthorizationStatusRestricted||status==kCLAuthorizationStatusDenied) {
            
        }
        else
        {
            [self startLocation];
        }
    }else
    {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        [self showAlv];
    }
}

- (void)showAlv
{
    NSString *message = @"您的手机目前并未开启定位服务，如欲开启定位服务，请至设置->隐私->定位服务，开启定位服务功能";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    return;
}

- (void)startLocation
{
    //设置代理
    _locationManager.delegate = self;
    //设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance = 10.0;//十米定位一次
    _locationManager.distanceFilter = distance;
    //启动跟踪定位
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    
    if (
        ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorizedWhenInUse) ||
        (![_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] && status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusAuthorized)
        ) {
        
        NSString *message = @"您的手机目前并未开启定位服务，如欲开启定位服务，请至设置->隐私->定位服务，开启定位服务功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }else {
        
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - CoreLocation 代理

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (_PTlocationError) {
        _PTlocationError(@"定位失败");
    }
}

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    self.PTlatitude = coordinate.latitude;
    self.PTLongtitude = coordinate.longitude;
    [self.gisDic setObject:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"latitude"]; //纬度
    [self.gisDic setObject:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"longitude"];
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}


#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
        NSString * city = [placemark.addressDictionary objectForKey:@"City"];
        NSLog(@"%@",city);
        
        CLLocationCoordinate2D PTcoordinate;
        PTcoordinate.latitude = self.PTlatitude;
        PTcoordinate.longitude = self.PTLongtitude;
        if (_PTcity) {
            _PTcity(PTcoordinate, city);
        }
        if (city) {
            [self.gisDic setObject:city forKey:@"City"];
        }
        
    }];
}

@end