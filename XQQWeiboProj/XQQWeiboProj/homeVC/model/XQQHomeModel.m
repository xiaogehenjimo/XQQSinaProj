//
//  XQQHomeModel.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/30.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQHomeModel.h"

@implementation XQQHomeModel
- (instancetype)init{
    if (self = [super init]) {
        _userModel = [[XQQUserModel alloc]init];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"user"]) {
        [_userModel setValuesForKeysWithDictionary:value];
    }else if([key isEqualToString:@"id"]){
        
    }else if([key isEqualToString:@"pic_urls"]){
        NSArray * valueArr = (NSArray*)value;
        if (valueArr.count > 0) {
            //转photoModel
            NSMutableArray * tmpArr = @[].mutableCopy;
            for (NSDictionary * item in valueArr) {
                XQQPhotoModel * photoModel = [[XQQPhotoModel alloc]init];
                [photoModel setValuesForKeysWithDictionary:item];
                [tmpArr addObject:photoModel];
            }
            self.photoModelArr = tmpArr;
        }
    }else if ([key isEqualToString:@"retweeted_status"]){
        self.retweetedModel = [[XQQHomeModel alloc]init];
        [self.retweetedModel setValuesForKeysWithDictionary:value];
    }
}
- (void)setUserModel:(XQQUserModel *)userModel{
    _userModel = userModel;
}
/**
 * 来源
 */
- (void)setSource:(NSString *)source{
    if (!source||[source isEqualToString:@""]) {
        _source = @"";
        return;
    }
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
}

//时间
- (NSString*)created_at{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    //真机调试需要转换这种偶美时间 需要设置locale
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_us"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // _created_at = @"Tue Sep 30 17:06:25 +0800 2014";
    NSDate * create = [fmt dateFromString:_created_at];
    //当前时间
    NSDate * now = [NSDate date];
    //日历对象(比较两个日期之间的差距)
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit unit 枚举出想要获得哪些值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents * cmps =  [calendar components:unit fromDate:create toDate:now options:0];
    if ([create isThisYear]) {//是否为今年
        if ([create isYesterday]) {//是否为昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        }else if ([create isToday]){//是否为今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:create];
    }
}

@end
