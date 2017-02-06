//
//  HWEmotionTool.h
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWEmotion;

@interface HWEmotionTool : NSObject
+ (void)addRecentEmotion:(HWEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;
/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (HWEmotion *)emotionWithChs:(NSString *)chs;

@end
