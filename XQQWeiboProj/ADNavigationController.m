//
//  ADNavigationController.m
//  Product1-WeChat
//
//  Created by Naibin on 16/3/9.
//  Copyright © 2016年 Naibin. All rights reserved.
//

#import "ADNavigationController.h"

@interface ADNavigationController ()

@end

@implementation ADNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置导航条
    [self setupNavigationBar];
}

// 配置导航条
- (void)setupNavigationBar {
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
