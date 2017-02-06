//
//  allFaceView.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/8.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "allFaceView.h"

#import "NSString+emoji.h"
#import "XQQPopView.h"
#import "XQQFaceBtn.h"
#define boardWidth 10
#define KCount 7
#define panding 10
#define photoWH   (iphoneWidth - 8 * boardWidth)/7
#define photoH    (250 - 4 * panding - panding)/3
@interface allFaceView ()
/**
 * frame
 */
@property(nonatomic,assign)CGRect myFrame;
/** 点击表情后弹出的放大镜 */
@property (nonatomic, strong) XQQPopView *popView;
//存按钮的数组
@property(nonatomic, strong)  NSMutableArray  *  buttonArr;
@end

@implementation allFaceView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _myFrame = frame;
    }
    return self;
}
- (void)setDetailFaceArr:(NSArray *)detailFaceArr{
    _detailFaceArr = detailFaceArr;
    for (NSInteger i = 0; i < detailFaceArr.count; i ++) {
        XQQFaceModel * model = detailFaceArr[i];
        CGFloat x = i % KCount * (photoWH  + panding) + panding;
        CGFloat y = i / KCount * (photoWH  + 2*panding) + 1 * panding;
        XQQFaceBtn * button = [[XQQFaceBtn alloc]initWithFrame:CGRectMake(x, y, photoWH, photoWH)];
        button.model = model;
        //添加长按手势
       [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
        
        [button addTarget:self action:@selector(buttonDidSel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArr addObject:button];
    }
}
- (void)buttonDidSel:(XQQFaceBtn*)faceBtn{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"face" object:faceBtn.model];
}

- (void)longPressPageView:(UILongPressGestureRecognizer*)recognizer{
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的表情按钮
    
    UIButton * button = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView removeFromSuperview];
            // 如果手指还在表情按钮上
            if (button) {
                // 发出通知
                [self selectEmotion:button];
            }
            break;
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            [self.popView showFrom:button];
            break;
        }
        default:
            break;
    }

}
/**
 *  根据手指位置所在的表情按钮
 */
- (UIButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.detailFaceArr.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.buttonArr[i];
        if (CGRectContainsPoint(btn.frame, location)) {
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
- (void)selectEmotion:(UIButton *)emotion
{
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //userInfo[HWSelectEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelFace" object:nil userInfo:userInfo];
}
- (NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = @[].mutableCopy;
    }
    return _buttonArr;
}
- (XQQPopView *)popView
{
    if (!_popView) {
        self.popView = [[XQQPopView alloc]initWithFrame:CGRectMake(0, 0, 64, 91)];
    }
    return _popView;
}
@end
