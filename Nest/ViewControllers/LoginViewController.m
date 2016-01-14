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

/**
 * Load's the auth url in the web view.
 */
- (void)loadAuthURL
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.authURL]];
    [self.webView loadRequest:request];
}

- (IBAction)onCancel:(UIBarButtonItem *)sender
{
    if ([self.delegate respondsToSelector:@selector(loginViewControllerDidCancelRequest:)]) {
        [self.delegate loginViewControllerDidCancelRequest:self];
    }
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

/**
 * Intercept the requests to get the authorization code.
 */
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
        
        // Clean the string
//        NSString *urlResources = [url resourceSpecifier];
//        urlResources = [urlResources stringByReplacingOccurrencesOfString:QUESTION_MARK withString:EMPTY_STRING];
//        urlResources = [urlResources stringByReplacingOccurrencesOfString:HASHTAG withString:EMPTY_STRING];
//        
//        // Seperate the /
//        NSArray *urlResourcesArray = [urlResources componentsSeparatedByString:SLASH];
//        
//        // Get all the parameters after /
//        NSString *urlParamaters = [urlResourcesArray objectAtIndex:([urlResourcesArray count]-1)];
//        
//        // Separate the &
//        NSArray *urlParamatersArray = [urlParamaters componentsSeparatedByString:AMPERSAND];
//        NSString *keyValue = [urlParamatersArray lastObject];
//        NSArray *keyValueArray = [keyValue componentsSeparatedByString:EQUALS];
//        
//        // We found the code
//        if([[keyValueArray objectAtIndex:(0)] isEqualToString:@"code"]) {
//            
//            // Send it to the delegate
//            [self.delegate foundAuthorizationCode:[keyValueArray objectAtIndex:1]];
//            
//        } else {
//            NSLog(@"Error retrieving the authorization code.");
//        }
//        
//        return NO;
    }
    
    return YES;
}




@end
