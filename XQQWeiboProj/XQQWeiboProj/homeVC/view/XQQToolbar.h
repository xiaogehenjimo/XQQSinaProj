//
//  XQQToolbar.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/2.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQQHomeModel;
@interface XQQToolbar : UIView

+ (instancetype)toolbar;

@property(nonatomic, strong)  XQQHomeModel  *  homeModel;
/**
 *  点击事件的block
 */
@property (nonatomic, copy)  void(^toolBarBtnPrss)(NSInteger btnTag);
@end
