//
//  ZYScanResultViewController.m
//  CumulativeMicro
//
//  Created by 朱忠阳 on 2017/6/15.
//  Copyright © 2017年 朱忠阳. All rights reserved.
//

#import "ZYScanResultViewController.h"
#import <WebKit/WebKit.h>

@interface ZYScanResultViewController () <WKNavigationDelegate, WKUIDelegate>

@end

@implementation ZYScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描结果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.resultString hasPrefix:@"http"]) {
        [self initWebView];
    }else {
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.text = self.resultString;
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.font = [UIFont systemFontOfSize:Level*14.f];
        tipLabel.numberOfLines = 0;
        [self.view addSubview:tipLabel];
        
        WS(weakSelf)
        [tipLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.left).offset(Level*10);
            make.right.equalTo(weakSelf.view.right).offset(Level*-10);
            make.top.equalTo(weakSelf.view.top);
        }];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
}


- (void)initWebView {
    [self showHint:@"加载中..."];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.resultString]]];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self hidesHUD];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self hidesHUD];
    [self.view makeToast:@"页面加载失败"];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"aaa");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
