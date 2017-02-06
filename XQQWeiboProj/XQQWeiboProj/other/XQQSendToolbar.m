//
//  XQQSendToolbar.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/6.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQSendToolbar.h"

@implementation XQQSendToolbar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.barStyle = UIBarStyleDefault;
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:.8];
        NSMutableArray * itemArr = @[].mutableCopy;
        NSArray * NormalImageArr = @[@"compose_toolbar_picture",@"compose_mentionbutton_background",@"compose_trendbutton_background",@"compose_emoticonbutton_background",@"compose_camerabutton_background"];
        NSArray * selImageArr = @[@"compose_toolbar_picture_highlighted",@"compose_mentionbutton_background_highlighted",@"compose_trendbutton_background_highlighted",@"compose_emoticonbutton_background_highlighted",@"compose_camerabutton_background_highlighted"];
        //创建button
        for (NSInteger i = 0; i < NormalImageArr.count; i ++) {
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            [button setBackgroundImage:[[UIImage imageNamed:NormalImageArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [button setBackgroundImage:[[UIImage imageNamed:selImageArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            if (i == 3) {
                self.faceBtn = button;
            }
            button.tag = 95598 + i;
            [button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
            [itemArr addObject:item];
            [itemArr addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        }
        [itemArr removeLastObject];
        [itemArr insertObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] atIndex:0];
        [itemArr addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]];
        [self setItems:itemArr animated:YES];
    }
    return self;
}

- (void)buttonDidPress:(UIButton*)button{
    _buttonDidPress(button.tag - 95598);
}
@end
