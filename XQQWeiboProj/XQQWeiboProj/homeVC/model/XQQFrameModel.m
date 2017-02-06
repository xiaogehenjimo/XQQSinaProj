//
//  XQQFrameModel.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/31.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQFrameModel.h"
#import "XQQHomeModel.h"
#import "XQQUserModel.h"
#import "XQQPhotoModel.h"
#import "XQQPhotoView.h"


@implementation XQQFrameModel

- (void)setModel:(XQQHomeModel *)model{
    _model = model;
    XQQUserModel * user = model.userModel;
    //图片模型数组
    NSArray * photoModelArr = model.photoModelArr;
    
    //取出转发微博的模型
    XQQHomeModel *  retweetedModel = model.retweetedModel;
    
    
    /**
     *  头像
     */
    CGFloat iconWH = 50;
    CGFloat iconX = cellBoderWidth;
    CGFloat iconH = cellBoderWidth;
    self.iconImageViewFrame = CGRectMake(iconX,iconH,iconWH, iconWH);
    /**
     *  昵称
     */
    CGFloat nameX = CGRectGetMaxX(self.iconImageViewFrame) + cellBoderWidth;
    CGFloat nameY = cellBoderWidth;
    CGSize nameSize = [self sizeWithText:user.name AndFont:cellNameFont];
    self.nameLabelFrame = (CGRect){{nameX,nameY},nameSize};
    /**
     *  会员图
     */
    //model.userModel.mbtype
    if ([model.userModel.mbrank integerValue] > 2) {
        //才是会员
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + cellBoderWidth;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipImageViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /**
     *  时间
     */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame) + cellBoderWidth;
    CGSize  timeSize = [self sizeWithText:model.created_at AndFont:cellTimeFont];
    self.timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
    /**
     *  来源
     */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + cellBoderWidth;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [self sizeWithText:model.source AndFont:cellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceX,sourceY},sourceSize};
    /**
     *  正文
     */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconImageViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + cellBoderWidth;
    CGFloat maxW = iphoneWidth - 2 * contentX;
    CGSize  contentSize = [self sizeWithText:model.text AndFont:cellContentFont MaxW:maxW];
    self.contentLabelFrame = (CGRect){{contentX,contentY},contentSize};
    //原创微博的高
    CGFloat originalH = 0;
    /**
     *  配图
     */
    if (photoModelArr.count) {//有图片
        //CGFloat photoWH = 100;
        //        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + cellBoderWidth;
        CGFloat  photoViewHeight = [XQQPhotoView photoViewHeight:photoModelArr.count];
        self.photoImageViewFrame = CGRectMake(0, photoY, iphoneWidth, photoViewHeight);
        originalH = CGRectGetMaxY(self.photoImageViewFrame) + cellBoderWidth;
    }else{//没有配图
        self.photoImageViewFrame = CGRectMake(0, CGRectGetMaxY(self.contentLabelFrame) + cellBoderWidth, 0, 0);
        originalH = CGRectGetMaxY(self.contentLabelFrame) + cellBoderWidth;
    }
    /**
     * 原创微博(整体)
     */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = iphoneWidth;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    //******************我是分割线********************
    CGFloat toobarY = 0;
    //转发微博
    if (retweetedModel) {
        //计算frame
        CGFloat retContentX = cellBoderWidth;
        CGFloat retContentY = cellBoderWidth;
        CGFloat maxW = iphoneWidth - 2 * contentX;
        CGSize  retContentSize = [self sizeWithText:[NSString stringWithFormat:@"%@ : %@",retweetedModel.userModel.name,retweetedModel.text] AndFont:cellRetweetContentFont MaxW:maxW];
        self.retweetContentLabelFrame = (CGRect){{retContentX,retContentY},retContentSize};
        NSArray * photoModelArr = retweetedModel.photoModelArr;
        
        CGFloat retweetH = 0;
        if (photoModelArr.count) {//有图片
            CGFloat photoY = CGRectGetMaxY(self.retweetContentLabelFrame) + cellBoderWidth;
            CGFloat  photoViewHeight = [XQQPhotoView photoViewHeight:photoModelArr.count];
            self.retweetPhotoImageViewFrame = CGRectMake(0, photoY, iphoneWidth, photoViewHeight);
            retweetH = CGRectGetMaxY(self.retweetPhotoImageViewFrame) + cellBoderWidth;
        }else{//没有配图
            self.retweetPhotoImageViewFrame = CGRectMake(0, CGRectGetMaxY(self.retweetContentLabelFrame) + cellBoderWidth, 0, 0);
            retweetH = CGRectGetMaxY(self.retweetContentLabelFrame) + cellBoderWidth;
        }
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetW = iphoneWidth;
        
        self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toobarY = CGRectGetMaxY(self.retweetViewFrame);
    }else{
        toobarY = CGRectGetMaxY(self.originalViewFrame);
    }
    //toolbar的frame
    CGFloat toobarX = 0;
    CGFloat toobarW = iphoneWidth;
    CGFloat toobarH = 40;
    self.toolBarFrame = CGRectMake(toobarX, toobarY, toobarW, toobarH);
    
    //cell的高度
    _cellHeight = CGRectGetMaxY(self.toolBarFrame) +2* cellBoderWidth;
}
//计算文字
- (CGSize)sizeWithText:(NSString*)text AndFont:(UIFont*)font MaxW :(CGFloat)maxW{
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithText:(NSString*)text AndFont:(UIFont*)font {
    return [self sizeWithText:text AndFont:font MaxW:MAXFLOAT];
}
@end
