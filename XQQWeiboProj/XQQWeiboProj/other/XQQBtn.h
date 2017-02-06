//
//  XQQBtn.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQQBtn : UIView
/**
 *  上方的图片
 */
@property(nonatomic, strong)  UIImageView  *  topImageView;
/**
 *  底部的label
 */
@property(nonatomic, strong)  UILabel  *  bottomLabel;
/**
 *  选中的block
 */
@property (nonatomic, copy)    void(^XQQBtnDidSel)();
@end
