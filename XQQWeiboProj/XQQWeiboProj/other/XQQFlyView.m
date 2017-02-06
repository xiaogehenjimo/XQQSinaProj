//
//  XQQFlyView.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQFlyView.h"
#import "XQQBtn.h"
#define KCount 3
#define panding 10
#define photoW  (iphoneWidth-4*panding)/3
#define photoH  80
@interface XQQFlyView ()<UIScrollViewDelegate>
/**
 * 中间的滚动视图
 */
@property (nonatomic, strong) UIScrollView * centerScrollView;
/**
 * secondView
 */
@property(nonatomic, strong)   UIView * secondView;
/**
 * firstView
 */
@property(nonatomic, strong)  UIView * firstView;
/**
 * 记录按钮点击
 */
@property(nonatomic, assign)  BOOL   isExitBtnClicked;
/**
 * 退出按钮
 */
@property(nonatomic, strong)   UIButton * exitBtn;
/**
 * 记录scrollview 是否滚动
 */
@property(nonatomic, assign)  BOOL   isScrollView;
/**
 * 返回按钮
 */
@property(nonatomic, strong)  UIButton  *  returnBtn;

@end

@implementation XQQFlyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        _isScrollView = NO;
        _isExitBtnClicked = NO;
        //顶部广告view
        _topADView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 200)];
        //下方的X view
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
        //X号按钮
        _exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.frame.size.width/2-10, 10, 20, 20)];
        
        //        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"publish_close_n@2x"] forState:UIControlStateNormal];
        [_exitBtn setImage:[UIImage imageNamed:@"publish_close_n@2x"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnDidPress) forControlEvents:UIControlEventTouchUpInside];
        _exitBtn.transform = CGAffineTransformMakeRotation(-M_PI/4);
        _bottomView.backgroundColor = [UIColor colorWithRed:202/255.0 green:202/255.0  blue:202/255.0  alpha:1];
        
        [_bottomView addSubview:_exitBtn];
        
        [self addSubview:_topADView];
        [self addSubview:_bottomView];
        
        //中间的view
        _selView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topADView.frame)+20, self.width, self.height - _topADView.frame.size.height - _bottomView.frame.size.height - 20)];
        
        _selView.userInteractionEnabled = YES;
        
        //添加滚动视图
        _centerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, _selView.frame.size.width, _selView.frame.size.height - 20)];
        
        _centerScrollView.contentSize = CGSizeMake(2 * _selView.frame.size.width, 0);
        _centerScrollView.scrollEnabled = _isScrollView;
        _centerScrollView.pagingEnabled = YES;
        _centerScrollView.alwaysBounceVertical = NO;
        _centerScrollView.delegate = self;
        _centerScrollView.userInteractionEnabled = YES;
        _centerScrollView.showsVerticalScrollIndicator = NO;
        _centerScrollView.showsHorizontalScrollIndicator = NO;
        //添加button
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _selView.frame.size.width, _selView.frame.size.height)];
        _firstView.userInteractionEnabled = YES;
        NSArray * firstImageNameArr = @[
                                        @[@"publish_0",@"publish_1",@"publish_2@2x"],
                                        @[@"publish_3@2x",@"publish_4@2x",@"publish_5@2x"]
                                        ];
        NSArray * firstTitleArr = @[
                                    @[@"文字",@"照片/视频",@"头条文章"],
                                    @[@"签到",@"直播",@"更多"]
                                    ];
        //第一个图添加6个按钮
        
        for (NSInteger i = 0; i < 2; i ++) {
            for (NSInteger j = 0; j < 3; j ++) {
                
                XQQBtn * button = [[XQQBtn alloc]initWithFrame:CGRectMake(30 + 120 * j, 80 + 120 * i + 500, 80, 105)];
                button.topImageView.image = [UIImage imageNamed:firstImageNameArr[i][j]];
                button.bottomLabel.text = firstTitleArr[i][j];
                button.tag =  3 * i + j + 20;
                __weak typeof(button)weakBtn = button;
                button.XQQBtnDidSel = ^(){
                    [self selBtnDidPressWithBtnTag:weakBtn.tag];
                };
                [_firstView addSubview:button];
                //CGRect ff = CGRectMake(50 + 120 * j, 80 + 120 * i, 80, 105);
                [UIView animateWithDuration:.8f delay:.2f + j * 0.05 usingSpringWithDamping:.6f initialSpringVelocity:.004f options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y - 500, button.frame.size.width, button.frame.size.height);
                    _exitBtn.transform = CGAffineTransformMakeRotation(0);
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
        
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(_selView.frame.size.width, 0,_selView.frame.size.width, _selView.frame.size.height)];
        _secondView.userInteractionEnabled = YES;
        //第二个图添加6个按钮
        NSArray * secondImageNameArr = @[
                                        @[@"publish_0",@"publish_1",@"publish_2@2x"],
                                         @[@"publish_3@2x",@"publish_4@2x",@"publish_5@2x"]
                                         ];
        NSArray * secondTitleArr = @[
                                     @[@"点评",@"好友圈",@"音乐"],
                                     @[@"红包",@"商品",@"秒拍"]
                                     ];
        for (NSInteger i = 0; i < 2; i ++) {
            for (NSInteger j = 0; j < 3; j ++) {
                XQQBtn * button = [[XQQBtn alloc]initWithFrame:CGRectMake(50 + 120 * j, 80 + 120 * i, 80, 105)];
                button.topImageView.image = [UIImage imageNamed:secondImageNameArr[i][j]];
                button.bottomLabel.text = secondTitleArr[i][j];
                button.tag = 3 * i + j + 40;
                __weak typeof(button)weakBtn = button;
                button.XQQBtnDidSel = ^(){
                    [self selBtnDidPressWithBtnTag:weakBtn.tag];
                };
                [_secondView addSubview:button];
            }
        }
        [_centerScrollView addSubview:_firstView];
        [_centerScrollView addSubview:_secondView];
        [_selView addSubview:_centerScrollView];
        [self addSubview:_selView];
        
    }
    return self;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [self ReturnBtnDidPress];
    }
}
/**
 *  按钮点击
 */
- (void)selBtnDidPressWithBtnTag:(NSInteger)tag{
    _buttonClicked(tag);
    if (tag == 25) {
        //修改偏移量
        if (_isScrollView) {
            [UIView animateWithDuration:.5f animations:^{
                _centerScrollView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                _centerScrollView.scrollEnabled = NO;
                _isScrollView = NO;
            }];
            
        }else{
            //添加返回按钮
            [_bottomView addSubview:self.returnBtn];
            _exitBtn.frame = CGRectMake(_bottomView.frame.size.width/2, 0, _bottomView.frame.size.width/2, 44);
            [UIView animateWithDuration:.5f animations:^{
                _centerScrollView.contentOffset = CGPointMake(_centerScrollView.frame.size.width, 0);
            } completion:^(BOOL finished) {
                _centerScrollView.scrollEnabled = YES;
                _isScrollView = YES;
            }];
        }
    }
}

- (void)ReturnBtnDidPress{
    [UIView animateWithDuration:.3f animations:^{
        _centerScrollView.contentOffset = CGPointMake(0, 0);
        _exitBtn.frame = CGRectMake(_bottomView.frame.size.width/2-10, 10, 20, 20);
        _centerScrollView.scrollEnabled = NO;
        _isScrollView = NO;
        [self.returnBtn removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self exitBtnDidPress];
}
/**
 *  退出按钮点击
 */
- (void)exitBtnDidPress{
    NSArray * subViews =  _firstView.subviews;
    NSArray * secondViews = _secondView.subviews;
    for (NSInteger i = subViews.count - 1; i  >= 0; i --) {
        XQQBtn * button = subViews[i];
        XQQBtn * second = secondViews[i];
        [UIView animateWithDuration:.3f delay:.3f - i * 0.05  options:UIViewAnimationOptionAllowUserInteraction animations:^{
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y + 500, 80, 105);
            second.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y + 500, 80, 105);
            if (_isExitBtnClicked) {
                
                _isExitBtnClicked = NO;
            }else{
                _exitBtn.transform = CGAffineTransformMakeRotation(-M_PI/4);
                _isExitBtnClicked = YES;
            }
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _exitBlock();
            });
        }];
    }
}
#pragma mark - setter&getter
- (UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width/2, 44)];
        [_returnBtn setTitle:@"<--" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(ReturnBtnDidPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

@end
