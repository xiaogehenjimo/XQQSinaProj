//
//  mainViewController.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/29.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import "XQQTitleBtn.h"
#import "XQQHomeModel.h"
#import "XQQHomeTableViewCell.h"
#import "XQQFrameModel.h"
#import "AppDelegate.h"


#import "MWPhotoBrowser.h"
#import "NirKxMenu.h"
#import "XQQNavgationController.h"
@interface mainViewController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>
@property(nonatomic,assign) BOOL isTitleViewPress;
/*头视图的图片*/
@property(nonatomic, strong)  UIImageView * titleImageView;
/*头视图*/
@property(nonatomic, strong)  UIView    * titleView;
/*头视图点击出现的view*/
@property(nonatomic, strong)  UIView  *  titleHomeView;
/*左侧按钮*/
@property(nonatomic, strong)  UIButton  *  leftBtn;
/*右侧按钮*/
@property(nonatomic, strong)  UIButton  *  rightBtn;
/*数据源*/
@property(nonatomic, strong)  NSMutableArray  *  XQQDataArr;
/*tabelView*/
@property(nonatomic, strong)  UITableView  *  homeTabelView;
/*token*/
@property (nonatomic, copy)  NSString  *  token;
/*UID*/
@property (nonatomic, copy)  NSString  *  uid;
/*定时器*/
@property(nonatomic, strong)  NSTimer  *  myTimer;
/*未读微博数*/
@property(nonatomic, assign)  NSInteger   unRedCount;
/*左下方首页item*/
@property(nonatomic, strong)  UITabBarItem  *  homeItem;
/*下拉刷新后出现的view*/
@property(nonatomic, strong)  UIView  *  refreshView;
/*刷新的view上得label*/
@property(nonatomic, strong)  UILabel  *  countLabel;
/*图片浏览器的数组*/
@property(nonatomic, strong)  NSMutableArray  *  photos;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //读取token
    NSDictionary * userInfo1 = [[LPUtility unarchiveDataFromCache:@"userInfo"] firstObject];
    NSString * token = userInfo1[@"access_token"];
    _token = token;
    _uid = userInfo1[@"uid"];
    [self createView];
    
    //获取用户信息
    [self getUserNameWithToken:token AndUID:userInfo1[@"uid"]];
    //请求数据
    [self loadDataWithToken:token];
    
}
#pragma mark - 网络请求
/**
 *  获取未读数
 */
- (void)unreadCount{
    [UIPHttpRequest startRequestFromUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" Andmethod:@"GET" AndParameter:@{@"uid":_uid,@"access_token":_token} returnData:^(id data, NSError *error) {
        NSDictionary * countDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if (!error) {
            NSLog(@"%@",countDict);
            _unRedCount = [countDict[@"status"] integerValue];
            //更新tabbar 数据
            if (_unRedCount == 0) {
                _homeItem.badgeValue = nil;
            }else{
                _homeItem.badgeValue = [NSString stringWithFormat:@"%ld",_unRedCount];
            }
        }else{
            
        }
    }];
}
/**
 *  上拉加载更多
 */
- (void)pullUpMoreData{
    XQQFrameModel * model = self.XQQDataArr.lastObject;
    XQQHomeModel * homeModel = model.model;
    if (homeModel.idstr  == nil || [homeModel.idstr  isEqualToString:@""]) {
        [self.homeTabelView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [UIPHttpRequest startRequestFromUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" Andmethod:@"GET" AndParameter:@{@"access_token":_token,@"count":@"10",@"max_id":homeModel.idstr } returnData:^(id data, NSError *error) {
        if (!error) {
            if (data) {
                NSDictionary * infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSArray * statuses = infoDict[@"statuses"];
                NSLog(@"%@",statuses);
                NSMutableArray * tmpArr = @[].mutableCopy;
                for (NSDictionary * item in statuses) {
                    XQQFrameModel * model = [[XQQFrameModel alloc]init];
                    XQQHomeModel * homeModel = [[XQQHomeModel alloc]init];
                    [homeModel setValuesForKeysWithDictionary:item];
                    model.model = homeModel;
                    [tmpArr addObject:model];
                }
                XQQFrameModel * frameModel = tmpArr.firstObject;
                XQQHomeModel * homeModel = frameModel.model;
                if ([homeModel.idstr isEqualToString:homeModel.idstr]) {
                    //移除重复的
                    [tmpArr removeFirstObject];
                }
                [self.XQQDataArr addObjectsFromArray:tmpArr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self refreshTabelView];
                });
            }else{
                //没有更多数据了
                [self.homeTabelView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            NSLog(@"请求错误");
            [self.homeTabelView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
}
/**
 * 下拉刷新
 */
- (void)refreshNewData{
    
    XQQFrameModel * model = self.XQQDataArr.firstObject;
    XQQHomeModel * homeModel = model.model;
    //XQQUserModel * userModel = homeModel.userModel;
    if (homeModel.idstr == nil || [homeModel.idstr  isEqualToString:@""]) {
        [self.homeTabelView.mj_header endRefreshing];
        return;
    }
    [UIPHttpRequest startRequestFromUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" Andmethod:@"GET" AndParameter:@{@"access_token":_token,@"count":@"10",@"since_id":homeModel.idstr } returnData:^(id data, NSError *error) {
        if (!error) {
            if (data) {
                NSDictionary * infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSArray * statuses = infoDict[@"statuses"];
                NSLog(@"%@",statuses);
                for (NSDictionary * item in statuses) {
                    XQQFrameModel * model = [[XQQFrameModel alloc]init];
                    XQQHomeModel * homeModel = [[XQQHomeModel alloc]init];
                    [homeModel setValuesForKeysWithDictionary:item];
                    model.model = homeModel;
                    [self.XQQDataArr insertObject:model atIndex:0];
                }
                NSInteger count = statuses.count;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self refreshTabelView];
                    _unRedCount = 0;
                    _homeItem.badgeValue = nil;
                    //改变刷新的view的frame
                    [self refreshAnimationWithLabelCount:[NSString stringWithFormat:@"%ld",count]];
                });
            }else{
                //没有更多数据了
                [self.homeTabelView.mj_header endRefreshing];
            }
            
        }else{
            NSLog(@"请求错误");
            [self.homeTabelView.mj_header endRefreshing];
        }
    }];
    
}
/**
 *  刷新表格
 */
- (void)refreshTabelView{
    [self.homeTabelView reloadData];
    if ([self.homeTabelView.mj_header isRefreshing]) {
        [self.homeTabelView.mj_header endRefreshing];
    }
    if ([self.homeTabelView.mj_footer isRefreshing]) {
        [self.homeTabelView.mj_footer endRefreshing];
    }
}
/**
 *
 *
 *  @param token token
 */
- (void)loadDataWithToken:(NSString*)token{
    
    [UIPHttpRequest startRequestFromUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" Andmethod:@"GET" AndParameter:@{@"access_token":token,@"count":@"10"} returnData:^(id data, NSError *error) {
        if (!error) {
            NSDictionary * infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray * statuses = infoDict[@"statuses"];
            NSLog(@"%@",statuses);
            for (NSDictionary * item in statuses) {
                XQQFrameModel * model = [[XQQFrameModel alloc]init];
                XQQHomeModel * homeModel = [[XQQHomeModel alloc]init];
                [homeModel setValuesForKeysWithDictionary:item];
                model.model = homeModel;
                [self.XQQDataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshTabelView];
            });
        }else{
            NSLog(@"请求错误%@",error);
        }
    }];
}
/**
 *  请求用户信息
 *
 *  @param token token
 *  @param uid   uid
 */
- (void)getUserNameWithToken:(NSString*)token AndUID:(NSString*)uid{
    
    [UIPHttpRequest startRequestFromUrl:@"https://api.weibo.com/2/users/show.json" Andmethod:@"GET" AndParameter:@{@"access_token":token,@"uid":uid} returnData:^(id data, NSError *error) {
        if (!error) {
            NSDictionary * userInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString * userName = userInfoDict[@"screen_name"];
            // NSLog(@"用户昵称:%@",userName);
            //创建头视图
            [self createTitleViewWithName:userName];
            //保存用户名
            [LPUtility archiveData:@[[NSString stringWithFormat:@"%@",userName]] IntoCache:@"userName"];
        }else{
            NSLog(@"请求失败");
        }
    }];
}

#pragma mark - UITabelViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.XQQDataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XQQHomeTableViewCell * cell = [XQQHomeTableViewCell cellWithTabelView:tableView WithIndexPath:indexPath];
    //给cell传递模型数据
    cell.FrameModel = self.XQQDataArr[indexPath.row];
    //    cell.photoBrowser = ^(XQQFrameModel*FrameModel,NSInteger index){
    //         NSArray * photoArr =  FrameModel.model.photoModelArr;
    //        [self creatBrowserWithPhotoArr:photoArr AndIndex:index];
    //    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQQFrameModel * model = self.XQQDataArr[indexPath.row];
    return model.cellHeight;
}
- (void)creatBrowserWithPhotoArr:(NSArray*)photoArr AndIndex:(NSInteger)index{
    self.photos = [NSMutableArray array];
    
    for (XQQPhotoModel * photoModel in photoArr) {
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:photoModel.thumbnail_pic]]];
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    [browser setCurrentPhotoIndex:index];
    
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - activity
- (void)buttonDidPress:(UIButton*)button{
    switch (button.tag) {
        case 998:{
            //左
        }
            
            break;
        case 999:{
            //右
        }
            break;
        default:
            break;
    }
}
#pragma mark - setter&getter
- (void)createView{
    //头视图
    _isTitleViewPress = NO;
    _homeItem = self.tabBarController.tabBar.items[0];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
        rightItem;
    });
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.view addSubview:self.homeTabelView];
    
    //读取未读消息数
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:20.f target:self selector:@selector(unreadCount) userInfo:nil repeats:YES];
        [_myTimer setFireDate:[NSDate distantPast]];
}
- (UIView *)refreshView{
    if (!_refreshView) {
        _refreshView = [[UIView alloc]initWithFrame:CGRectMake(0, -200, iphoneWidth, 50)];
        _refreshView.backgroundColor = [UIColor yellowColor];
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _refreshView.frame.size.width, 50)];
        
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [_refreshView addSubview:_countLabel];
    }
    return _refreshView;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        [_rightBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        _rightBtn.tag = 999;
        [_rightBtn addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_leftBtn setImage:[UIImage imageNamed:@"左侧"] forState:UIControlStateNormal];
        _leftBtn.tag = 998;
        [_leftBtn addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UITableView *)homeTabelView{
    if (!_homeTabelView) {
        _homeTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight ) style:UITableViewStylePlain];
        _homeTabelView.delegate = self;
        _homeTabelView.dataSource = self;
        [_homeTabelView registerClass:[XQQHomeTableViewCell class] forCellReuseIdentifier:@"states"];
        _homeTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
        [_homeTabelView.mj_header beginRefreshing];
        _homeTabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpMoreData)];
    }
    return _homeTabelView;
}
//创建头视图
- (void)createTitleViewWithName:(NSString*)name{
    CGSize size = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width + 40, 44)];
    //创建label
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, _titleView.frame.size.height)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = name;
    //添加imageView
    _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, nameLabel.frame.origin.y + 7, 30, 30)];
    _titleImageView.image = [UIImage imageNamed:@"timeline_icon_more_highlighted"];
    [_titleView addSubview:nameLabel];
    [_titleView addSubview:_titleImageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleViewDidPress)];
    [_titleView addGestureRecognizer:tap];
    self.navigationItem.titleView = self.titleView;
}
- (void)clike{
    
}
/**
 *  头视图被点击
 */
- (void)titleViewDidPress{
    if (_isTitleViewPress) {
        _titleImageView.transform = CGAffineTransformMakeRotation(0);
        [KxMenu dismissMenu];
        _isTitleViewPress = NO;
    }else{
         _titleImageView.transform = CGAffineTransformMakeRotation(M_PI);
        [self showSliderView];
        _isTitleViewPress = YES;
    }
}
- (UIView *)titleHomeView{
    if (!_titleHomeView) {
        _titleHomeView = [[UIView alloc]initWithFrame:CGRectMake(iphoneWidth/2-100, CGRectGetMaxY(self.titleView.frame)+20, 200, 300)];
        _titleHomeView.backgroundColor = [UIColor yellowColor];
    }
    return _titleHomeView;
}
- (NSMutableArray *)XQQDataArr{
    if (!_XQQDataArr) {
        _XQQDataArr = [[NSMutableArray alloc]init];
    }
    return _XQQDataArr;
}
/**
 *  刷新完做出的动画View
 */
- (void)refreshAnimationWithLabelCount:(NSString*)count{
    [self.view addSubview:self.refreshView];
    CGRect refreshFrame = _refreshView.frame;
    if ([count isEqualToString:@"0"]) {
        _countLabel.text = @"没有最新的微博了";
    }else{
        _countLabel.text = [NSString stringWithFormat:@"%@ %@",count,@"条新微博"];
    }
    [UIView animateWithDuration:1.f animations:^{
        _refreshView.frame = CGRectMake(refreshFrame.origin.x, 64, refreshFrame.size.width, refreshFrame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.f delay:.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
            _refreshView.frame = CGRectMake(refreshFrame.origin.x, -200, refreshFrame.size.width, refreshFrame.size.height);
        } completion:^(BOOL finished) {
            [self.refreshView removeFromSuperview];
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
- (void)showSliderView{
    NSArray *menuArray = @[
                           [KxMenuItem menuItem:@"扫一扫" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)],
                           [KxMenuItem menuItem:@"加好友" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)],
                           [KxMenuItem menuItem:@"创建讨论组" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)],
                           [KxMenuItem menuItem:@"发送到电脑" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)],
                           [KxMenuItem menuItem:@"面对面快传" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)],
                           [KxMenuItem menuItem:@"收钱" image:[UIImage imageNamed:@"Touch"] target:self action:@selector(clike)]
                           ];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:15]];
    OptionalConfiguration optional;
    optional.arrowSize=9;
    optional.marginXSpacing=7;
    optional.marginYSpacing=9;
    optional.intervalSpacing=25;
    optional.menuCornerRadius=6.5;
    optional.maskToBackground=false;
    optional.shadowOfMenu = true;
    optional.hasSeperatorLine = true;
    optional.seperatorLineHasInsets = false;
    Color color;
    color.R = 0;
    color.G = 0;
    color.B = 0;
    Color color1;
    color1.R = 1;
    color1.G = 1;
    color1.B = 1;
    optional.textColor = color;
    optional.menuBackgroundColor = color1;
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication].delegate window] fromRect:_titleView.frame menuItems:menuArray withOptions:optional];
}

@end
