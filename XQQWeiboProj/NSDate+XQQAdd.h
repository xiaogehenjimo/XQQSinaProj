//
//  NSDate+XQQAdd.h
//  XQQWeiboProj
//
//  Created by XQQ on 2017/2/6.
//  Copyright © 2017年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XQQAdd)
/*判断某个时间是否为今年*/
- (BOOL)isThisYear;

/**判断某个时间是否为昨天*/
- (BOOL)isYesterday;

/**判断某个时间是否为今天*/
- (BOOL)isToday;
@end
