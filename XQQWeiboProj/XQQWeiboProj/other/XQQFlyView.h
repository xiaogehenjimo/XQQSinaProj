//
//  XQQFlyView.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XQQFlyView : UIView
/**
 * 顶部广告View
 */
@property(nonatomic, strong)  UIView  *  topADView;
/**
 *  最下方带X View
 */
@property(nonatomic, strong)  UIView  *  bottomView;
/**
 *  选择的View
 */
@property(nonatomic, strong)  UIView  *  selView;
/**
 *  退出按钮的block
 */
@property (nonatomic, copy)  void(^exitBlock)();
/**
 *  按钮点击的block
 */
@property (nonatomic, copy)  void(^buttonClicked)(NSInteger index);
@end
