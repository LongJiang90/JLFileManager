//
//  ShowFileVC.h
//  AFNetworking
//
//  Created by xp on 2018/3/13.
//

#import <UIKit/UIKit.h>
#import "FileInfo.h"

@protocol SFWebViewDelegate <NSObject>

@optional
- (BOOL)sf_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)sf_webViewDidStartLoad:(UIWebView *)webView;
- (void)sf_webViewDidFinishLoad:(UIWebView *)webView;
- (void)sf_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface ShowFileVC : UIViewController

@property (nonatomic, strong) FileInfo *aFile;

@property (nonatomic, assign) id <SFWebViewDelegate> delegate;

@end
