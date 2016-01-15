//
//  MainTabBarController.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "MainTabBarController.h"
#import "AuthManager.h"
#import "LoginViewController.h"


@interface MainTabBarController () <LoginViewControllerDelegate>
@property (nonatomic, assign) BOOL preventAuthFlow;
@end


@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.preventAuthFlow &&
        ![[AuthManager sharedManager] isValidSession])
    {
        [self showLoginControllerAnimated:NO];
    }
}

#pragma mark - Private

- (void)showLoginControllerAnimated:(BOOL)animated
{
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginVC.authURL = [AuthManager authorizationURL];
    loginVC.redirectURL = [AuthManager redirectURL];
    loginVC.delegate = self;
    [self presentViewController:loginVC animated:animated completion:nil];
}

- (void)showTryAgainAlertWithMessage:(NSString *)message
{
    WEAKIFY_SELF
    [self showAlertWithTitle:@"Error"
                     message:message
                     okTitle:@"Try again"
                     okBlock:^{
                         STRONGIFY_SELF
                         [self dismissViewControllerAnimated:NO completion:nil];
                         [self showLoginControllerAnimated:NO];
                     }];
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewController:(LoginViewController *)loginVC didFoundAuthCode:(NSString *)authCode withState:(NSString *)state
{
    self.preventAuthFlow = YES;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([state isEqualToString:[AuthManager state]] &&
        authCode != nil)
    {
        AuthManager *authManager = [AuthManager sharedManager];
        authManager.authCode = authCode;
        
        [SVProgressHUD showWithStatus:@"Authenticating"];
        WEAKIFY_SELF
        [authManager requestAuthTokenWithSuccess:^(NSString *authToken) {
            
            STRONGIFY_SELF
            [SVProgressHUD dismiss];
            self.preventAuthFlow = NO;
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            
            STRONGIFY_SELF
            [SVProgressHUD dismiss];
            self.preventAuthFlow = NO;
            [self showTryAgainAlertWithMessage:error.localizedDescription];
        }];
    }
    else {
        self.preventAuthFlow = NO;
        [self showTryAgainAlertWithMessage:@"Cannot get auth code"];
    }
}

- (void)loginViewControllerDidCancelRequest:(LoginViewController *)loginVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Public

- (void)performLogout
{
    [self showLoginControllerAnimated:YES];
}


@end
