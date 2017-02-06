//
//  XQQBtn.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQBtn.h"

@implementation XQQBtn

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 25)];
        //_topImageView.backgroundColor = [UIColor redColor];
//        _topImageView.layer.cornerRadius = 30;
//        _topImageView.layer.masksToBounds = YES;
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        //_bottomLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_topImageView];
        [self addSubview:_bottomLabel];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSel)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)didSel{
    _XQQBtnDidSel();
}
@end
