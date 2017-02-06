//
//  XQQFaceSmallView.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/8.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allFaceView.h"
@interface XQQFaceSmallView : UIScrollView
/**
 *  表情的数组
 */
@property(nonatomic, strong)  NSArray  *  faceArr;
/**
 *  传递当前页的page 和总数
 */
@property (nonatomic, copy)  void(^pageControlBlock)(NSInteger pageCount,NSInteger currentPage);

@end
