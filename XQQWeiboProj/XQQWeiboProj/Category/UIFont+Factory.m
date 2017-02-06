//
//  UIFont+Factory.m
//  Secretary
//
//  Created by liuxiaowu on 15/8/5.
//
//

#import "UIFont+Factory.h"

@implementation UIFont (Factory)

//34px 17号
+ (UIFont *)lp_font1
{
    return [UIFont systemFontOfSize:17];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:17];
}

//34px 17号，粗体
+ (UIFont *)lp_boldFont1
{
    return [UIFont boldSystemFontOfSize:17];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:17];
}

//32px 16号
+ (UIFont *)lp_font2
{
    return [UIFont systemFontOfSize:16];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:16];
}

+ (UIFont *)lp_boldFont2
{
    return [UIFont boldSystemFontOfSize:16];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:16];
}

//30px 15号
+ (UIFont *)lp_font3
{
    return [UIFont systemFontOfSize:15];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:15];
}

+ (UIFont *)lp_boldFont3
{
    return [UIFont boldSystemFontOfSize:15];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:15];
}

//28px 14号
+ (UIFont *)lp_font4
{
    return [UIFont systemFontOfSize:14];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:14];
}

//28px 14号粗体
+ (UIFont *)lp_boldFont4
{
    return [UIFont boldSystemFontOfSize:14];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:14];
}


//26px 13号
+ (UIFont *)lp_font5
{
    return [UIFont systemFontOfSize:13];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:13];
}
//26px 13号
+ (UIFont *)lp_boldFont5
{
    return [UIFont boldSystemFontOfSize:13];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:13];
}


//24px 12号
+ (UIFont *)lp_font6
{
    return [UIFont systemFontOfSize:12];
    //return [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:12];
}

//24px 12号
+ (UIFont *)lp_boldFont6
{
    return [UIFont boldSystemFontOfSize:12];
    //return [UIFont fontWithName:@"FZLanTingHei-DB-GBK" size:12];
}



//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//+ (UIFont *)systemFontOfSize:(CGFloat)fontSize{
//    UIFont *customFont=[UIFont fontWithName:CustomFontName size:fontSize];
//    return customFont;
//}
//
//+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize{
//    UIFont *customFont=[UIFont fontWithName:CustomFontName size:fontSize];
//    return customFont;
//}
@end
