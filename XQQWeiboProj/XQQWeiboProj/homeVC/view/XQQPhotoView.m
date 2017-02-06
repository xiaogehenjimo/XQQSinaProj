//
//  XQQPhotoView.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/9/1.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQPhotoView.h"
#import "XQQPhotoModel.h"
#define KCount 3
#define panding 10
#define photoW  (iphoneWidth-4*panding)/3
#define photoH  120
@implementation XQQPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}
- (void)initPhotoWithPhotoArr:(NSArray*)photoArr{
    for (NSInteger i = 0; i < photoArr.count; i ++) {
        XQQPhotoModel * photoModel = photoArr[i];
        CGFloat x = i % KCount * (photoW  + panding) + panding;
        CGFloat y = i / KCount * (photoH  + panding) + panding;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, photoW, photoH)];
        imageView.tag = 2000 + i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPress:)];
        [imageView addGestureRecognizer:tap];
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoModel.thumbnail_pic]];
       // imageView.backgroundColor = [UIColor blueColor];
        [self addSubview:imageView];
    }
}

- (void)imageViewPress:(UITapGestureRecognizer*)tap{
    UIImageView * imageView = (UIImageView*)tap.view;

    _imagePress(imageView.tag - 2000);
}

+ (CGFloat)photoViewHeight:(NSInteger)PhotoCount{
    
    return ((PhotoCount - 1)/KCount + 1)  * (photoH  + panding) + panding;
    
}
@end
