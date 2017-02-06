//
//  XQQFaceView.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/7.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQQFaceView : UIView
/**
 *  底部的scrollView
 */
@property(nonatomic, strong)  UIScrollView  *  bottomScrollView;
/**
 *  上面的大scrollView
 */
@property(nonatomic, strong)  UIScrollView  *  topBigScrollView;
/**
 *  下方选择按钮点击的block
 */
@property (nonatomic, copy)  void(^bottomFaceTypeBtnPress)(NSInteger btnIndex);
@end
