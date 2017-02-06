//
//  UIColor+Helpers.m
//  FreeBird
//
//  Created by xu-wenchao on 15/8/10.
//  Copyright (c) 2015年 liepin. All rights reserved.
//

#import "UIColor+Helpers.h"

@implementation UIColor (Helpers)

//16进制颜色
+ (UIColor *)colorWithHexString:(NSString *)hexString{
    unsigned int red = 0, green = 0, blue = 0;
    NSRange range = NSMakeRange(0, 2);
    if([hexString hasPrefix:@"#"]){
        range = NSMakeRange(1, 2);
    }
    else if([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]){
        range = NSMakeRange(2, 2);
    }
    
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&red];
    range.location = range.location + range.length;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&green];
    range.location = range.location + range.length;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}


@end
