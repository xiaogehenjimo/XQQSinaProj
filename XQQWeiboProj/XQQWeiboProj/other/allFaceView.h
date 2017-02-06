//
//  allFaceView.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/8.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQQFaceModel.h"
@interface allFaceView : UIView
/**
 *  点击的block
 */
@property (nonatomic, copy)  void(^faceBtnDidSel)(XQQFaceModel * model);
/**
 *  表情数组
 */
@property(nonatomic, strong)  NSArray  *  detailFaceArr;

@end
