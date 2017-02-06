//
//  XQQSendToolbar.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/6.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQQSendToolbar : UIToolbar
/**
 *  按钮点击事件
 */
@property (nonatomic, copy)  void(^buttonDidPress)(NSInteger btnTag);
/**
 *  记录表情的按钮
 */
@property(nonatomic, strong)  UIButton  *  faceBtn;
@end
