//
//  UIAlertView+LPBlock.h
//  ios-tongdao-app
//
//  Created by 向纯 陈 on 16/1/15.
//
//

#import <UIKit/UIKit.h>

typedef void (^LPAlertBlock) (NSUInteger buttonIndex);

@interface UIAlertView (LPBlock)

@property (nonatomic, copy) LPAlertBlock block;

- (void)showLPAlertViewWithLPAlertBlock:(LPAlertBlock)block;

@end
