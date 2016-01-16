//
//  LoginWebViewController.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "LoginViewController.h"
#import <RequestUtils.h>


@interface LoginViewController () <UIWebViewDelegate>
@end


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadAuthURL];
}

- (void)loadAuthURL
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.authURL]];
    [self.webView loadRequest:request];
}

#pragma mark UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSURL *redirectURL = [[NSURL alloc] initWithString:self.redirectURL];
    
    if ([[url host] isEqualToString:[redirectURL host]] &&
        [[url path] isEqualToString:[redirectURL path]]) {
        
        NSDictionary *params = [[url query] URLQueryParameters];
        
        if ([self.delegate respondsToSelector:@selector(loginViewController:didFoundAuthCode:withState:)]) {
            [self.delegate loginViewController:self
                              didFoundAuthCode:params[@"code"]
                                     withState:params[@"state"]];
        }
        
        return NO;
    }
    
    return YES;
}




@end
