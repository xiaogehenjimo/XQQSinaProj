//
//  meViewController.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "meViewController.h"

@interface meViewController ()
/**
 *  左侧按钮
 */
@property(nonatomic, strong)  UIButton * leftBtn;
/**
 *  右侧按钮
 */
@property(nonatomic, strong)  UIButton  *  rightBtn;
@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //初始化UI
    [self createUI];
   //请求数据
    [self initData];
}

/**
 *  请求数据
 */
- (void)initData{
    [UIPHttpRequest startRequestFromUrl:@"" Andmethod:@"" AndParameter:@{} returnData:^(id data, NSError *error) {
        
    }];
}
/**
 *  createUI
 */
- (void)createUI{
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
        leftItem;
    });
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
        rightItem;
    });
}
#pragma mark - activity
- (void)leftBtnDidPress{
    
}

- (void)rightBtnDidPress{
    
}

#pragma mark - setter&getter

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_rightBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_rightBtn addTarget:self action:@selector(rightBtnDidPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_leftBtn setTitle:@"添加好友" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_leftBtn addTarget:self action:@selector(leftBtnDidPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
