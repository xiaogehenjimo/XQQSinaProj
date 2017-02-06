//
//  XQQToolbar.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/2.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQToolbar.h"
#import "XQQHomeModel.h"
@interface XQQToolbar ()
/**
 *  里面存放所有的按钮
 */
@property(nonatomic, strong)    NSMutableArray * btnArr;
/**
 *  存放所有的分割线
 */
@property(nonatomic, strong)    NSMutableArray  *  dividerArr;
/**
 *  repost
 */
@property(nonatomic, strong)  UIButton  *  repostBtn;
/**
 *  comment
 */
@property(nonatomic, strong)  UIButton  *  commentBtn;
/**
 *  attitude
 */
@property(nonatomic, strong)  UIButton  *  attitudeBtn;
@end

@implementation XQQToolbar
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        //添加按钮
        self.repostBtn = [self setUpButtonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.repostBtn.tag = 10086;
        [self.repostBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.commentBtn = [self setUpButtonWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.commentBtn.tag = 10087;
        [self.commentBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.attitudeBtn = [self setUpButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        self.attitudeBtn.tag = 10088;
        [self.attitudeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //添加分割线
        [self setUpDivider];
        [self setUpDivider];
    }
    return self;
}
/**
 * 绑定点击事件
 */
- (void)buttonClicked:(UIButton*)button{
    _toolBarBtnPrss(button.tag);
}

- (void)setHomeModel:(XQQHomeModel *)homeModel{
    _homeModel = homeModel;
    //转发
    [self setUpButtonCount:[homeModel.reposts_count integerValue] button:self.repostBtn title:@"转发"];
    //评论
    [self setUpButtonCount:[homeModel.comments_count integerValue] button:self.commentBtn title:@"评论"];
    //赞
    [self setUpButtonCount:[homeModel.attitudes_count integerValue] button:self.attitudeBtn title:@"赞"];
}


- (void)setUpButtonCount:(NSInteger)count
                  button:(UIButton*)button
                   title:(NSString*)title{
    if (count) {//数字不为0
        if (count < 1000) {//不足1000直接显示数字
            title = [NSString stringWithFormat:@"%ld",count];
        }else{//达到一万以上 显示11.1W 不能有.0
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            //将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置frame
    NSInteger buttonCount = self.btnArr.count;
    CGFloat btnW = self.width / buttonCount;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i < buttonCount; i ++) {
        UIButton * button = self.btnArr[i];
        button.y = 0;
        button.x = i * btnW;
        button.width = btnW;
        button.height = btnH;
    }
    //设置分割线的frame
    NSInteger divierCount = self.dividerArr.count;
    for (NSInteger i = 0; i < divierCount; i ++) {
        UIImageView * divier = self.dividerArr[i];
        divier.width = 1;
        divier.height = btnH;
        divier.x = (i + 1) * btnW;
        divier.y = 0;
    }
}
/**
 *  添加分割线
 */
- (void)setUpDivider{
    UIImageView * divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividerArr addObject:divider];
}
/**
 * 创建按钮
 */
- (UIButton*)setUpButtonWithTitle:(NSString*)title icon:(NSString*)icon{
    UIButton * button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    [self.btnArr addObject:button];
    return button;
}
+ (instancetype)toolbar{
    return [[self alloc]init];
}
#pragma mark - setter
- (NSMutableArray *)dividerArr{
    if (!_dividerArr) {
        _dividerArr = @[].mutableCopy;
    }
    return _dividerArr;
}
- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = @[].mutableCopy;
    }
    return _btnArr;
}
@end
