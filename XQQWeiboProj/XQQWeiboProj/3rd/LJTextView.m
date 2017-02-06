//
//  LJTextView.m
//  我的小微博
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "LJTextView.h"

@implementation LJTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeHolderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:16];
        // 通知
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}
/** 监听文字改变 */
- (void)textChange{
    [self setNeedsDisplay];
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = self.font;
    dic[NSForegroundColorAttributeName] = self.placeHolderColor;
    [self.placeHolder drawInRect:CGRectMake(rect.origin.x + 5, 8, rect.size.width - 10, rect.size.height - 16) withAttributes:dic];
}

@end
