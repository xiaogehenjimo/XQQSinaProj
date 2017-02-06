//
//  XQQTabBarController.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQTabBarController.h"
#import "XQQNavgationController.h"
#import "mainViewController.h"
#import "messageViewController.h"
#import "findViewController.h"
#import "meViewController.h"
#import "XQQTabBar.h"
//#import "XQQFlyViewController.h"
#import "XQQFlyView.h"
#import "AppDelegate.h"
#import "sendViewController.h"
@interface XQQTabBarController ()<XQQTabBarDelegate>
/**
 *  tabBar
 */
@property(nonatomic, strong)  XQQTabBar * myTabBar;
@end

@implementation XQQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加子视图控制器
    [self setUpViewControllers];
    //配置tabbar
    [self setUpTabBar];
    
}

- (void)setUpViewControllers{
    NSMutableArray * controllers = @[].mutableCopy;
    NSArray * titleArr = @[@"首页",@"消息",@"发现",@"我"];
    NSArray * normolImaneName = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    NSArray * selImageName = @[@"tabbar_home_selected",@"tabbar_message_center_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
    NSArray * controllersName = @[@"mainViewController",@"messageViewController",@"findViewController",@"meViewController"];
    for (NSInteger i = 0; i < controllersName.count; i ++) {
        Class class = NSClassFromString(controllersName[i]);
        UIViewController * vc = [[class alloc]init];
        vc.title = titleArr[i];
        vc.tabBarItem.image = [UIImage imageNamed:normolImaneName[i]];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        XQQNavgationController * nav = [[XQQNavgationController alloc]initWithRootViewController:vc];
        [controllers addObject:nav];
    }
    self.tabBarController.selectedIndex = 0;
    self.viewControllers = controllers;
}

- (void)setUpTabBar{
    _myTabBar = [[XQQTabBar alloc]init];
    _myTabBar.delegater = self;
    [self setValue:_myTabBar forKey:@"tabBar"];
}

#pragma mark - XQQTabBarDelegate
- (void)tabBarDidClickedPlusBtn:(XQQTabBar*)tabBar{
    tabBar.hidden = YES;
    XQQFlyView * view = [[XQQFlyView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
    [self.view addSubview:view];
    __weak typeof(view)weakView = view;
    view.exitBlock = ^(){
        [weakView removeFromSuperview];
        tabBar.hidden = NO;
    };
    view.buttonClicked = ^(NSInteger index){
        sendViewController * sendVC = [[sendViewController alloc]init];
        XQQNavgationController * sendNavController = [[XQQNavgationController alloc]initWithRootViewController:sendVC];
        [weakView removeFromSuperview];
        sendVC.cancelBtnPress = ^(){
            tabBar.hidden = NO;
        };
        [self presentViewController:sendNavController animated:YES completion:nil];
        switch (index) {
            case 20:{
                //文字
                
            }
                break;
            case 21:{
                //照片
                NSLog(@"照片");
            }
                break;
            case 22:{
                //头条
                NSLog(@"头条");
            }
                break;
            case 23:{
                //签到
                NSLog(@"签到");
            }
                break;
            case 24:{
                //直播
                NSLog(@"直播");
            }
                break;
            case 25:{
                //更多
                NSLog(@"更多");
            }
                break;
            case 40:{
                //点评
                NSLog(@"点评");
            }
                break;
            case 41:{
                //好友圈
                NSLog(@"好友圈");
            }
                break;
            case 42:{
                //音乐
                NSLog(@"音乐");
            }
                break;
            case 43:{
                //红包
                NSLog(@"红包");
            }
                break;
            case 44:{
                //商品
                NSLog(@"商品");
            }
                break;
            case 45:{
                //秒拍
                NSLog(@"秒拍");
            }
                break;
            default:
                break;
        }
        
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
