//
//  XQQUserModel.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/30.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQUserModel.h"

@implementation XQQUserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if ([key isEqualToString:@"class"]) {
        _userClass = value;
    }else if ([key isEqualToString:@"description"]) {
        _descript = value;
    }else{
        
    }
}
- (instancetype)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
