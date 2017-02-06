//
//  XQQFirstViewController.m
//  XQQWeiboProj
//
//  Created by XQQ on 16/8/30.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQFirstViewController.h"
#import "AppDelegate.h"
@interface XQQFirstViewController ()<UIWebViewDelegate>
/**
 *  webView
 */
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation XQQFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=1222832087&redirect_uri=%@",kRedirectURL]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneHeight - 64)];
        _webView.delegate = self;
    }
    return _webView;
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    HWLog(@"----webViewDidFinishLoad");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    HWLog(@"----webViewDidStartLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获得url
    NSString * url = request.URL.absoluteString;
    //判断是否为回调网址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        //是回调网址
        NSInteger fromIndex = range.location + range.length;
        NSString * code = [url substringFromIndex:fromIndex];
        //利用code获取一个accessToken
        [self accessTokenWithCode:code];
    }
    return YES;
}
/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code{
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kAPPKey;
    params[@"client_secret"] = AppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = kRedirectURL;
    params[@"code"] = code;

    [UIPHttpRequest startRequestFromUrl:@"https://api.weibo.com/oauth2/access_token" Andmethod:@"POST" AndParameter:params returnData:^(id data, NSError *error) {
        if (!error) {
            NSLog(@"请求成功%@",data);
            NSDictionary * userInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
            NSString * currentAppVersion = infoDict[@"CFBundleShortVersionString"];
            NSUserDefaults * defaultUser =  [NSUserDefaults standardUserDefaults];
            [defaultUser setValue:currentAppVersion forKey:@"appVersion"];
            [LPUtility archiveData:@[userInfoDict] IntoCache:@"userInfo"];
            AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [delegate enterMainVC];

        }else{
            NSLog(@"请求失败%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
