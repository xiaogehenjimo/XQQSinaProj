//
//  XQQHomeModel.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/30.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XQQUserModel.h"
#import "XQQPhotoModel.h"
@interface XQQHomeModel : NSObject
/**
 *   attitudes_count
 */
@property (nonatomic, copy)  NSString  *  attitudes_count;
/**
 *  biz_feature
 */
@property (nonatomic, copy)  NSString  *  biz_feature;
/**
 *  comments_count
 */
@property (nonatomic, copy)  NSString  *  comments_count;
/**
 *  created_at
 */
@property (nonatomic, copy)  NSString  *  created_at;
/**
 *  darwin_tags
 */
@property(nonatomic, strong)  NSArray  *  darwin_tags;
/**
 *  favorited
 */
@property (nonatomic, copy)  NSString  *  favorited;
/**
 *  geo
 */
@property (nonatomic, copy)  NSString  *  geo;
/**
 *  gif_ids
 */
@property (nonatomic, copy)  NSString  *  gif_ids;
/**
 *  hasActionTypeCard
 */
@property (nonatomic, copy)  NSString  *  hasActionTypeCard;
/**
 *  hot_weibo_tags
 */
@property(nonatomic, strong)  NSArray  *  hot_weibo_tags;
/**
 *  idstr
 */
@property (nonatomic, copy)  NSString  *  idstr;
/**
 *  in_reply_to_screen_name
 */
@property (nonatomic, copy)  NSString  *  in_reply_to_screen_name;
/**
 *  in_reply_to_status_id
 */
@property (nonatomic, copy)  NSString  *  in_reply_to_status_id;
/**
 *  in_reply_to_user_id
 */
@property (nonatomic, copy)  NSString  *  in_reply_to_user_id;
/**
 *  isLongText
 */
@property (nonatomic, copy)  NSString  *  isLongText;
/**
 *  is_show_bulletin
 */
@property (nonatomic, copy)  NSString  *  is_show_bulletin;
/**
 *  mid
 */
@property (nonatomic, copy)  NSString  *  mid;
/**
 *  mlevel
 */
@property (nonatomic, copy)  NSString  *  mlevel;
/**
 *  original_pic
 */
@property (nonatomic, copy)  NSString  *  original_pic;
/**
 *  pic_urls
 */
@property (nonatomic, strong)  NSArray  *  photoModelArr;
/**
 *  positive_recom_flag
 */
@property (nonatomic, copy)  NSString  *  positive_recom_flag;
/**
 *  reposts_count
 */
@property (nonatomic, copy)  NSString  *  reposts_count;
/**
 *  rid
 */
@property (nonatomic, copy)  NSString  *  rid;
/**
 *  source
 */
@property (nonatomic, copy)  NSString  *  source;
/**
 *  source_allowclick
 */
@property (nonatomic, copy)  NSString  *  source_allowclick;
/**
 *  source_type
 */
@property (nonatomic, copy)  NSString  *  source_type;
/**
 *  text
 */
@property (nonatomic, copy)  NSString  *  text;
/**
 *  textLength
 */
@property (nonatomic, copy)  NSString  *  textLength;
/**
 *  text_tag_tips
 */
@property(nonatomic, strong)  NSArray  *  text_tag_tips;
/**
 *  thumbnail_pic
 */
@property (nonatomic, copy)  NSString  *  thumbnail_pic;
/**
 *  truncated
 */
@property (nonatomic, copy)  NSString  *  truncated;
/**
 *  user
 */
@property (nonatomic, strong)  XQQUserModel  *  userModel;
/**
 *  userType
 */
@property (nonatomic, copy)  NSString  *  userType;
/**
 *  visible
 */
@property(nonatomic, strong)  NSDictionary  *  visible;
/**
 *  转发微博
 */
@property(nonatomic, strong)  XQQHomeModel  *  retweetedModel;
@end
