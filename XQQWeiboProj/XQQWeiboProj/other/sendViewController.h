//
//  sendViewController.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/6.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendViewController : UIViewController
/**
 *  取消的block
 */
@property (nonatomic, copy)  void (^cancelBtnPress)();
@end
