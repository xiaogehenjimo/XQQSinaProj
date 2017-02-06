//
//  UIFont+Factory.h
//  Secretary
//
//  Created by liuxiaowu on 15/8/5.
//
//

#import <UIKit/UIKit.h>

#define CustomFontName @"FZMiaoWuS-GB"

@interface UIFont (Factory)
/*!
 @brief 34px 17号字
*/
+ (UIFont *)lp_font1;
/*!
 @brief 34px 17号字，粗体
 */
+ (UIFont *)lp_boldFont1;

/*!
 @brief 32px 16号字
*/
+ (UIFont *)lp_font2;
/*!
 @brief 32px 16号字，粗体
 */
+ (UIFont *)lp_boldFont2;

/*!
 @brief 30px 15号字
 */
+ (UIFont *)lp_font3;
/*!
 30px 15号字，粗体
 */
+ (UIFont *)lp_boldFont3;

/*!
 @brief 28px 14号字
 */
+ (UIFont *)lp_font4;
/*!
 @brief 28px 14号字，粗体
 */
+ (UIFont *)lp_boldFont4;

/*!
 @brief 26px 13号字
 */
+ (UIFont *)lp_font5;
/*!
 @brief 26px 13号字，粗体
 */
+ (UIFont *)lp_boldFont5;

/*!
 @brief 24px 12号字
 */
+ (UIFont *)lp_font6;
/*!
 @brief 24px 12号字，粗体
 */
+ (UIFont *)lp_boldFont6;

//+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
@end
