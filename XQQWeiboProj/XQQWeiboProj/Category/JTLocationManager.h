//
//  JTLocationManager.h
//  IOS_108
//
//  Created by csctest on 16/5/30.
//  Copyright © 2016年 csctest. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>

@interface JTLocationManager : NSObject
@property (nonatomic, assign) double PTlatitude;
@property (nonatomic, assign) double PTLongtitude;
@property (nonatomic, assign) CLLocationCoordinate2D coore;
typedef void(^PTLocationCoordinateInfo)(CLLocationCoordinate2D coordinate);
typedef void(^PTLocationCity) (CLLocationCoordinate2D coordinate, NSString * city);
typedef void(^PTLocationError) (NSString * errorStr);

@property (nonatomic, strong) NSMutableDictionary * gisDic;

+ (instancetype)shareLocationManager;

@property (nonatomic ,copy) PTLocationCoordinateInfo coordinate;
@property (nonatomic, copy) PTLocationCity PTcity;
@property (nonatomic, copy) PTLocationError PTlocationError;

- (void)startGetLantitudeAndLongtitude;
- (void)showAlv;
@end
