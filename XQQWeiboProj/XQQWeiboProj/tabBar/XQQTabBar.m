//
//  XQQTabBar.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQTabBar.h"

@interface XQQTabBar ()

@property (nonatomic, strong) UIButton * plusBtn;

@end

@implementation XQQTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton * button = [[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(plusBtnDidPress) forControlEvents:UIControlEventTouchUpInside];
        button.size = button.currentBackgroundImage.size;
        [self addSubview:button];
        self.plusBtn = button;
    }
    return self;
}
- (void)plusBtnDidPress{
    if ([self.delegater respondsToSelector:@selector(tabBarDidClickedPlusBtn:)]) {
        [self.delegater tabBarDidClickedPlusBtn:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    //设置其他tabbar button 的frame
    CGFloat tabBarBtnW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView * child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置X
            child.x = tabBarButtonIndex * tabBarBtnW;
            //设置宽度
            child.width = tabBarBtnW;
            //增加索引
            tabBarButtonIndex ++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex ++;
            }
        }
    }
}


@end
