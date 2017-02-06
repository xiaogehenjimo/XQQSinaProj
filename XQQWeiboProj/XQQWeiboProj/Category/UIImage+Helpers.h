//
//  UIImage+Helpers.h
//  ccClient
//
//  Created by 蔡芊 on 15/7/11.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Helpers)
- (UIImage *)addImage:(UIImage *)secondImage ToPoint:(CGPoint)point;

+ (UIImage*)stretchableImageNamed:(NSString*)imageName; //拉伸图片
+ (UIImage*)imageWithColor:(UIColor*)color; //根据颜色生成图片
+ (UIImage*)screenshot; //屏幕截图
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize; //压缩成指定大小的图片

//改变图片背景颜色
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
//两张图片合成一张
- (UIImage *)composeImageWithBgImage:(UIImage *)bgImage image:(UIImage *)image;

@end
