//
//  AppDelegate.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "AppDelegate.h"
#import "XQQTabBarController.h"
#import "XQQFirstViewController.h"
@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAPPKey];
    
    //得到版本号
    NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
    
    NSString * currentAppVersion = infoDict[@"CFBundleShortVersionString"];
    //取出之前保存的版本号
    NSUserDefaults * defaultUser =  [NSUserDefaults standardUserDefaults];
    NSString * appVersion = [defaultUser stringForKey:@"appVersion"];
    //如果appVersion为空 第一次启动  如果 appVersion != currentAppVersion 说明是更新了
    if ([appVersion isEqualToString:@""]||appVersion == nil||appVersion !=currentAppVersion ) {
        //保存最新的版本号
        XQQFirstViewController * firstVC = [[XQQFirstViewController alloc]init];
        self.window.rootViewController = firstVC;
    }else{
        [self enterMainVC];
    }
    return YES;
}

- (void)enterMainVC{
    XQQTabBarController * tab = [[XQQTabBarController alloc]init];
    self.window.rootViewController = tab;
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
}
//重写handelurl  方法
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIBackgroundTaskIdentifier task = [application  beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
