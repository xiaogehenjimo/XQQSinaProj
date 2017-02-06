//
//  XQQFrameModel.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/31.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
//昵称字体
#define cellNameFont [UIFont systemFontOfSize:15]
//时间
#define cellTimeFont [UIFont systemFontOfSize:12]
//来源字体
#define cellSourceFont [UIFont systemFontOfSize:12]
//正文字体
#define cellContentFont [UIFont systemFontOfSize:14]

//转发正文字体
#define cellRetweetContentFont [UIFont systemFontOfSize:14]
/**
 * cell边框宽度
 */
#define cellBoderWidth 10
@class XQQHomeModel;
@interface XQQFrameModel : NSObject
/**
 *  数据模型
 */
@property(nonatomic, strong)  XQQHomeModel  *  model;
/**
 * 原创微博(整体)
 */
@property(nonatomic, assign)  CGRect originalViewFrame;
/**
 *  头像
 */
@property(nonatomic, assign)  CGRect  iconImageViewFrame;
/**
 *  会员图
 */
@property(nonatomic, assign)  CGRect   vipImageViewFrame;
/**
 *  配图
 */
@property(nonatomic, assign)  CGRect  photoImageViewFrame;
/**
 *  昵称
 */
@property(nonatomic, assign)  CGRect  nameLabelFrame;
/**
 *  时间
 */
@property(nonatomic, assign)  CGRect  timeLabelFrame;
/**
 *  来源
 */
@property(nonatomic, assign)  CGRect  sourceLabelFrame;
/**
 *  正文
 */
@property(nonatomic, assign)  CGRect  contentLabelFrame;
/**
 *  cell高度
 */
@property(nonatomic, assign)  CGFloat   cellHeight;

/**
 * 转发微博整体 Frame
 */
@property(nonatomic, assign)  CGRect   retweetViewFrame;//repost
/**
 *  转发微博正文 + 昵称 Frame
 */
@property(nonatomic, assign)  CGRect    retweetContentLabelFrame;
/**
 *  转发配图Frame
 */
@property(nonatomic, assign)  CGRect   retweetPhotoImageViewFrame;
/**
 *  工具条的frame
 */
@property(nonatomic, assign)  CGRect    toolBarFrame;


@end
