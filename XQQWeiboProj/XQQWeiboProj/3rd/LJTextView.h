//
//  LJTextView.h
//  我的小微博
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJTextView : UITextView<UITextViewDelegate>

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIColor *placeHolderColor;

@end
