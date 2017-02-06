//
//  UIAlertView+LPBlock.m
//  ios-tongdao-app
//
//  Created by 向纯 陈 on 16/1/15.
//
//

#import "UIAlertView+LPBlock.h"
#import <objc/runtime.h>

@implementation UIAlertView (LPBlock)
static void * LPAlertViewKey = @"LPAlertViewKey";

- (void)setBlock:(LPAlertBlock)block
{
    objc_setAssociatedObject(self, LPAlertViewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LPAlertBlock)block
{
    return objc_getAssociatedObject(self, LPAlertViewKey);
}

- (void)showLPAlertViewWithLPAlertBlock:(LPAlertBlock)block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, LPAlertViewKey, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LPAlertBlock block = objc_getAssociatedObject(self, LPAlertViewKey);
    if (block) {
        block(buttonIndex);
    }
}

@end
