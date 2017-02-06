//
//  XQQTabBar.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQQTabBar;

@protocol XQQTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickedPlusBtn:(XQQTabBar*)tabBar;

@end

@interface XQQTabBar : UITabBar

@property (nonatomic,assign) id <XQQTabBarDelegate> delegater;

@end




