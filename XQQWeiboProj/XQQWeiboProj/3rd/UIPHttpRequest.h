//
//  UIPHttpRequest.h
//  UIPowerTestProj
//
//  Created by XQQ on 16/8/3.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface UIPHttpRequest : NSObject
+(void)startRequestFromUrl:(NSString *)url
                 Andmethod:(NSString*)method
              AndParameter:(NSDictionary *)parameter
                returnData:(void (^)(id data, NSError *error))returnBlock;


@end
