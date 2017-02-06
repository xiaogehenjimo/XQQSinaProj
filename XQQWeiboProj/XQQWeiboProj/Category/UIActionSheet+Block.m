//
//  UIActionSheet+Block.m
//  ios-tongdao-app
//
//  Created by caiqian on 16/2/23.
//
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>
static char LPActionSheet_Property = 'p';

@implementation UIActionSheet (Block)

+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickBlock:(LPActionBlock)actionBlock{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    
    actionSheet.delegate = actionSheet;
    for (NSString *title in otherButtonTitles) {
        [actionSheet addButtonWithTitle:title];
    }
    
    objc_setAssociatedObject(actionSheet, &LPActionSheet_Property, actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return actionSheet;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LPActionBlock actionBlock = objc_getAssociatedObject(actionSheet, &LPActionSheet_Property);
    if (actionBlock) {
        actionBlock(buttonIndex);
    }
}
@end
