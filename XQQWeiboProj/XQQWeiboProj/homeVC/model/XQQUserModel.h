//
//  XQQUserModel.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/30.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQQUserModel : NSObject

@property (nonatomic, copy)  NSString  * allow_all_act_msg;
@property (nonatomic, copy)  NSString  * allow_all_comment;
@property (nonatomic, copy)  NSString  * avatar_hd;
@property (nonatomic, copy)  NSString  * avatar_large;
@property (nonatomic, copy)  NSString  * bi_followers_count;
@property (nonatomic, copy)  NSString  * block_app;
@property (nonatomic, copy)  NSString  * block_word;
@property (nonatomic, copy)  NSString  * city;
@property (nonatomic, copy)  NSString  * userClass;//class
@property (nonatomic, copy)  NSString  * cover_image;
@property (nonatomic, copy)  NSString  * cover_image_phone;
@property (nonatomic, copy)  NSString  * created_at;
@property (nonatomic, copy)  NSString  * credit_score;
@property (nonatomic, copy)  NSString  * descript;//description
@property (nonatomic, copy)  NSString  * domain;
@property (nonatomic, copy)  NSString  * favourites_count;
@property (nonatomic, copy)  NSString  * follow_me;
@property (nonatomic, copy)  NSString  * followers_count;
@property (nonatomic, copy)  NSString  * following;
@property (nonatomic, copy)  NSString  * friends_count;
@property (nonatomic, copy)  NSString  * gender;
@property (nonatomic, copy)  NSString  * geo_enabled;
@property (nonatomic, copy)  NSString  * ID;//id
@property (nonatomic, copy)  NSString  * idstr;
@property (nonatomic, copy)  NSString  * lang;
@property (nonatomic, copy)  NSString  * location;
/**
 *  会员等级
 */
@property (nonatomic, copy)  NSString  * mbrank;
/**
 *  值 > 2 才是会员
 */
@property (nonatomic, copy)  NSString  * mbtype;
@property (nonatomic, copy)  NSString  * name;
@property (nonatomic, copy)  NSString  * online_status;
@property (nonatomic, copy)  NSString  * pagefriends_count;
@property (nonatomic, copy)  NSString  * profile_image_url;
@property (nonatomic, copy)  NSString  * profile_url;
@property (nonatomic, copy)  NSString  * province;
@property (nonatomic, copy)  NSString  * ptype;
@property (nonatomic, copy)  NSString  * remark;
@property (nonatomic, copy)  NSString  * screen_name;
@property (nonatomic, copy)  NSString  * star;
@property (nonatomic, copy)  NSString  * statuses_count;
@property (nonatomic, copy)  NSString  * urank;
@property (nonatomic, copy)  NSString  * url;
@property (nonatomic, copy)  NSString  * user_ability;
@property (nonatomic, copy)  NSString  * verified;
@property (nonatomic, copy)  NSString  * verified_contact_email;
@property (nonatomic, copy)  NSString  * verified_contact_mobile;
@property (nonatomic, copy)  NSString  * verified_contact_name;
@property (nonatomic, copy)  NSString  * verified_level;
@property (nonatomic, copy)  NSString  * verified_reason;
@property (nonatomic, copy)  NSString  * verified_reason_modified;
@property (nonatomic, copy)  NSString  * verified_reason_url;
@property (nonatomic, copy)  NSString  * verified_source;
@property (nonatomic, copy)  NSString  * verified_source_url;
@property (nonatomic, copy)  NSString  * verified_state;
@property (nonatomic, copy)  NSString  * verified_trade;
@property (nonatomic, copy)  NSString  * verified_type;
@property (nonatomic, copy)  NSString  * verified_type_ext;
@property (nonatomic, copy)  NSString  * weihao;
/**
 *  会员等级
 */
/**
 *  会员类型
 */
@end
