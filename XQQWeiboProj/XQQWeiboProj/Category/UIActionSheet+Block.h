//
//  UIActionSheet+Block.h
//  ios-tongdao-app
//
//  Created by caiqian on 16/2/23.
//
//

#import <UIKit/UIKit.h>
typedef void(^LPActionBlock)(NSInteger clickIndex);
@interface UIActionSheet (Block)<UIActionSheetDelegate>

+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickBlock:(LPActionBlock)actionBlock;
@end
