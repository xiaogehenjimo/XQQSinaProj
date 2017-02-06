//
//  XQQHomeTableViewCell.h
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/31.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XQQFrameModel;
//typedef void(^photoBrowser)(XQQFrameModel*FrameModel,NSInteger index);
@interface XQQHomeTableViewCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView*)tabelView WithIndexPath:(NSIndexPath*)indexPath;
/**
 *  模型
 */
@property (nonatomic, strong)  XQQFrameModel  *  FrameModel;
//@property (nonatomic, copy)    photoBrowser  photoBrowser;
@end
