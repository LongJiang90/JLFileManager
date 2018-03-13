//
//  ShowFileVC.m
//  AFNetworking
//
//  Created by xp on 2018/3/13.
//

#import "ShowFileVC.h"

@interface ShowFileVC ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ShowFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    
    self.title = self.aFile.f_name;
    if (self.aFile.f_localPath.length > 5) {
        [self loadDocumentByPath:self.aFile.f_localPath];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 协议函数
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (self.delegate) {
        return [self.delegate sf_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (self.delegate) {
        [self.delegate sf_webViewDidStartLoad:webView];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.delegate) {
        [self.delegate sf_webViewDidStartLoad:webView];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.delegate) {
        [self.delegate sf_webView:webView didFailLoadWithError:error];
    }
}

#pragma mark - 组装数据、创建视图、自定义方法

-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _webView.scalesPageToFit=YES;
        _webView.multipleTouchEnabled=YES;
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

-(void)loadDocumentByPath:(NSString*)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
