//
//  NSString+XQQAdd.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/2.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "NSString+XQQAdd.h"

@implementation NSString (XQQAdd)
- (CGSize)sizeWithXQQFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithXQQFont:(UIFont *)font
{
    return [self sizeWithXQQFont:font maxW:MAXFLOAT];
}

@end
