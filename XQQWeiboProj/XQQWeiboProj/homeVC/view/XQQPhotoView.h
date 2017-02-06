//
//  XQQPhotoView.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/1.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^imageDidPress)(NSInteger index);
@interface XQQPhotoView : UIView
/**
 *  图片
 */
@property(nonatomic, strong)  UIImageView  *  photoImageView;
/**
 * 放置图片的view
 */
@property(nonatomic, strong)  UIView  *  bigView;

- (void)initPhotoWithPhotoArr:(NSArray*)photoArr;
+ (CGFloat)photoViewHeight:(NSInteger)PhotoCount;
/**
 *  block
 */
@property (nonatomic, copy)  imageDidPress  imagePress;



@end
