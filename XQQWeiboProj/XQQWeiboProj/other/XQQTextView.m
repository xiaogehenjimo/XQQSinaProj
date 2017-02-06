//
//  XQQTextView.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/6.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQTextView.h"

@implementation XQQTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeHolderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)textChange{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) {
        return;
    }
     NSString * str = @"输入你的内容...";
    [str drawInRect:CGRectMake(rect.origin.x + 5, 8, rect.size.width - 10 , rect.size.height - 16) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
}


@end
