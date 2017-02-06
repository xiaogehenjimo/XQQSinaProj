//
//  XQQHomeTableViewCell.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/31.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQHomeTableViewCell.h"
#import "XQQHomeModel.h"
#import "XQQFrameModel.h"
#import "XQQPhotoView.h"
#import "XQQToolbar.h"
#import "MWPhotoBrowser.h"
#import "XQQTabBarController.h"
#import "mainViewController.h"
#import "STPhotoBrowserController.h"
@interface XQQHomeTableViewCell ()<STPhotoBrowserDelegate>
/**
 * 原创微博(整体)
 */
@property(nonatomic, strong)  UIView * originalView;
/**
 *  头像
 */
@property(nonatomic, strong)  UIImageView  *  iconImageView;
/**
 *  会员图
 */
@property(nonatomic, strong)  UIImageView  *  vipImageView;
/**
 *  配图
 */
@property(nonatomic, strong)  UIImageView  *  photoImageView;
/**
 *  昵称
 */
@property(nonatomic, strong)  UILabel  *  nameLabel;
/**
 *  时间
 */
@property(nonatomic, strong)  UILabel  *  timeLabel;
/**
 *  来源
 */
@property(nonatomic, strong)  UILabel  *  sourceLabel;
/**
 *  正文
 */
@property(nonatomic, strong)  UILabel  *  contentLabel;
/**
 * 图片
 */
@property(nonatomic, strong)  XQQPhotoView  *  photoView;

/**
 * 转发微博
 */
/**
 * 转发微博整体
 */
@property(nonatomic, strong)  UIView  *  retweetView;//repost
/**
 *  转发微博正文 + 昵称
 */
@property(nonatomic, strong)  UILabel  *  retweetContentLabel;
/**
 *  转发配图
 */
@property(nonatomic, strong)  XQQPhotoView  *  retweetPhotoImageView;

/**
 * 工具条
 */
@property(nonatomic, strong)  XQQToolbar  *  toolBar;
/**
 * 图片浏览器的数组
 */
@property(nonatomic, strong)  NSArray  *  photos;

@end

@implementation XQQHomeTableViewCell
+ (instancetype)cellWithTabelView:(UITableView*)tabelView WithIndexPath:(NSIndexPath*)indexPath{
    static NSString * ID = @"states";
    //XQQHomeTableViewCell * cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    //    if (!cell) {
    //        cell = [[XQQHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    //    }
    XQQHomeTableViewCell * cell = [tabelView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        //初始化原创微博
        [self setUpOriginal];
        //初始化转发微博
        [self setUpRetweet];
        //初始化工具条
        [self setUpToolBar];
    }
    return self;
}

/**
 *  初始化工具条
 */
- (void)setUpToolBar{
    XQQToolbar  *  toolBar = [XQQToolbar toolbar];
    self.toolBar = toolBar;
    toolBar.toolBarBtnPrss = ^(NSInteger btnTag){
       //工具条点击方法
        [self toolBarDidPress:btnTag];
    };
    [self.contentView addSubview:toolBar];
}
/**
 *  工具条点击方法
 */
- (void)toolBarDidPress:(NSInteger)btnTag{
    switch (btnTag) {
        case 10086:
        {//转发
           NSLog(@"转发");
        }
            break;
        case 10087:
        {//评论
            NSLog(@"评论");
        }
            break;
        case 10088:
        {//赞
            NSLog(@"点赞");
        }
            break;
            
        default:
            break;
    }
}


- (void)setFrameModel:(XQQFrameModel *)FrameModel{
    _FrameModel = FrameModel;
    
    XQQHomeModel * homeModel = FrameModel.model;
    XQQUserModel * userModel = homeModel.userModel;
    //图片的数组
    NSArray * photoArr = homeModel.photoModelArr;
    
    self.originalView.frame = FrameModel.originalViewFrame;
    //self.originalView.backgroundColor = [UIColor redColor];
    self.iconImageView.frame = FrameModel.iconImageViewFrame;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //会员
    if ([userModel.mbtype integerValue] > 2) {
        self.vipImageView.frame = FrameModel.vipImageViewFrame;
        self.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"common_icon_membership_level",userModel.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipImageView.hidden = YES;
    }
    
    if (self.photoView.subviews) {
        for (UIView * view in self.photoView.subviews) {
            [view removeFromSuperview];
            //            UIImageView * imageView =(UIImageView*)view;
            //            imageView.image = [UIImage imageNamed:@""];
        }
    }
    
    
    if (photoArr.count) {
        self.photoView.frame = FrameModel.photoImageViewFrame;
        [self.photoView initPhotoWithPhotoArr:homeModel.photoModelArr];
    }
    
    
    self.nameLabel.frame = FrameModel.nameLabelFrame;
    self.nameLabel.text = userModel.name;
    /** 时间 */
    NSString *time = homeModel.created_at;
    CGFloat timeX = FrameModel.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(FrameModel.nameLabelFrame) + cellBoderWidth;
    CGSize timeSize = [time sizeWithXQQFont:cellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + cellBoderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [homeModel.source sizeWithXQQFont:cellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = homeModel.source;
    
    self.contentLabel.frame = FrameModel.contentLabelFrame;
    self.contentLabel.text = homeModel.text;
    
    for (UIView * view in self.retweetPhotoImageView.subviews) {
        [view removeFromSuperview];
    }
    
    //被转发的微博
    if (homeModel.retweetedModel) {
        XQQHomeModel * retHomeModel = homeModel.retweetedModel;
        XQQUserModel * retUserModel = retHomeModel.userModel;
        self.retweetView.hidden = NO;
        self.retweetView.frame = FrameModel.retweetViewFrame;
        //拼接转发的文字
        NSString * retText = [NSString stringWithFormat:@"@%@ : %@",retUserModel.name,retHomeModel.text];
        NSMutableAttributedString * attributent = [[NSMutableAttributedString alloc]initWithString:retText];
        [attributent addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(0, retUserModel.name.length +1)];
        
        self.retweetContentLabel.frame = FrameModel.retweetContentLabelFrame;
        self.retweetContentLabel.attributedText = attributent;
        NSArray * photoArr = homeModel.retweetedModel.photoModelArr;
        if (photoArr.count) {
            self.retweetPhotoImageView.frame = FrameModel.retweetPhotoImageViewFrame;
            [self.retweetPhotoImageView initPhotoWithPhotoArr:photoArr];
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    
    self.toolBar.frame = FrameModel.toolBarFrame;
    self.toolBar.homeModel = homeModel;
}
//初始化转发微博
- (void)setUpRetweet{
    UIView  *  retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:.7];
    self.retweetView = retweetView;
    //retweetView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:retweetView];
    
    UILabel  *  retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = cellRetweetContentFont;
    self.retweetContentLabel = retweetContentLabel;
    [retweetView addSubview:retweetContentLabel];
    
    XQQPhotoView  *  retweetPhotoImageView = [[XQQPhotoView alloc]init];
    self.retweetPhotoImageView = retweetPhotoImageView;
     __weak typeof(retweetPhotoImageView)weakRetweetPhotoImageView = retweetPhotoImageView;
    retweetPhotoImageView.imagePress = ^(NSInteger index){
        _photos = _FrameModel.model.retweetedModel.photoModelArr;
        [self createPhotoBrowserWithSuperView:weakRetweetPhotoImageView AndIndex:index];
    };
    [retweetView addSubview:retweetPhotoImageView];
    
}
//初始化原创微博
- (void)setUpOriginal{
    //原创整体
    UIView * originalView = [[UIView alloc]init];
    self.originalView = originalView;
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    /**
     *  头像
     */
    UIImageView  *  iconImageView = [[UIImageView alloc]init];
    self.iconImageView = iconImageView;
    [originalView addSubview:iconImageView];
    /**
     *  会员图
     */
    UIImageView  *  vipImageView = [[UIImageView alloc]init];
    self.vipImageView = vipImageView;
    vipImageView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipImageView];
    /**
     *  配图
     */
    XQQPhotoView  *  photoImageView = [[XQQPhotoView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.photoView = photoImageView;
    __weak typeof(photoImageView)weakPhotoImageView = photoImageView;
    photoImageView.imagePress = ^(NSInteger index){
       //创建图片浏览器
         _photos = _FrameModel.model.photoModelArr;
        [self createPhotoBrowserWithSuperView:weakPhotoImageView AndIndex:index];
    };
    [originalView addSubview:photoImageView];
    /**
     *  昵称
     */
    UILabel  *  nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [originalView addSubview:nameLabel];
    /**
     *  时间
     */
    UILabel  *  timeLabel = [[UILabel alloc]init];
    self.timeLabel = timeLabel;
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = cellTimeFont;
    [originalView addSubview:timeLabel];
    /**
     *  来源
     */
    UILabel  *  sourceLabel = [[UILabel alloc]init];
    self.sourceLabel = sourceLabel;
    sourceLabel.font = cellSourceFont;
    [originalView addSubview:sourceLabel];
    /**
     *  正文
     */
    UILabel  *  contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = cellContentFont;
    self.contentLabel = contentLabel;
    [originalView addSubview:contentLabel];
    
}

- (void)createPhotoBrowserWithSuperView:(UIView*)superView AndIndex:(NSInteger)index{
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = superView; // 原图的父控件
    browserVc.countImage = _photos.count; // 图片总数
    browserVc.currentPage = index;
    browserVc.delegate = self;
    [browserVc show];
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    if (browser.sourceImagesContainerView == self.photoView) {
        NSArray * subViews =   self.photoView.subviews;
        UIImageView * imageView = subViews[index];
        return imageView.image;
    }else{
        NSArray * subViews =   self.retweetPhotoImageView.subviews;
        UIImageView * imageView = subViews[index];
        return imageView.image;
    }
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [_photos[index] thumbnail_pic];
    //XQQPhotoModel
    return [NSURL URLWithString:urlStr];
}

//- (CGSize)sizeThatFits:(CGSize)size{
//    return CGSizeMake(iphoneWidth, CGRectGetMaxY(self.toolBar.frame));
//}

@end
