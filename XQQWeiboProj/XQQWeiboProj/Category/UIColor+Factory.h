//
//  UIColor+Factory.h
//  Secretary
//
//  Created by liuxiaowu on 15/8/5.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Factory)
/*
 使用要按照设计稿标注的十六进制颜色值对应的color
 */


/*!
@brife 导航条颜色

*/
+ (UIColor *)JT_NavColor;

/*!
@brife #333333 黑色 用于重要文字、标题等（如动态人脉名称、职位标题、详情标题等）
*/
+ (UIColor *)lp_color1;

/*!
 @brife #666666 浅黑
 */
+ (UIColor *)lp_color2;

/*!
 @brife #999999 灰色
 */
+ (UIColor *)lp_color3;

/*!
 @brife #e8e8e8 浅灰
 */
+ (UIColor *)lp_color4;

/*!#dddddd 浅白
 */
+ (UIColor *)lp_color5;

/*!#f4f4f4 浅白
 */
+ (UIColor *)lp_color6;

/*!#fcfcfc 接近白色
 */
+ (UIColor *)lp_color7;

/*!#00a1e6 蓝色（链接）
 */
+ (UIColor *)lp_color8;

/*!#54cabc 浅绿色（用于要特别突出的内容）
 */
+ (UIColor *)lp_color9;

/*!#ff6446 浅红色（用于要特别突出的内容）
 */
+ (UIColor *)lp_color10;

/*!#ff9046 橘黄色（用于要特别突出的内容）
 */
+ (UIColor *)lp_color11;


/*!#f7f6f6 浅淡灰色（用于要特别突出的内容）
 */
+ (UIColor *)lp_color14;


/*!#cccccc按钮置灰状态
 */
+ (UIColor *)lp_color12;

/*!#3ac5a7点击下深绿色
 */
+ (UIColor *)lp_color13;


@end
