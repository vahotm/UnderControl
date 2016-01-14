//
//  LoginWebViewController.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewControllerDidCancelRequest:(LoginViewController *)loginVC;
- (void)loginViewController:(LoginViewController *)loginVC didFoundAuthCode:(NSString *)authCode withState:(NSString *)state;

@end


@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *authURL;
@property (nonatomic, strong) NSString *redirectURL;

@end
