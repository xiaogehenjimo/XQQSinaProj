//
//  UIPHttpRequest.m
//  UIPowerTestProj
//
//  Created by XQQ on 16/8/3.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "UIPHttpRequest.h"
#import <AFNetworking.h>
@implementation UIPHttpRequest

+(void)startRequestFromUrl:(NSString *)url Andmethod:(NSString*)method AndParameter:(NSDictionary *)parameter returnData:(void (^)(id  data, NSError *error))returnBlock {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([method isEqualToString:@"GET"]) {
        [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            returnBlock(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            returnBlock(nil,error);
        }];
    }else if([method isEqualToString:@"POST"]){
        [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            returnBlock(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            returnBlock(nil,error);
        }];
    }
}


@end


