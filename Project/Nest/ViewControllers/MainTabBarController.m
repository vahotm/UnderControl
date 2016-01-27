//
//  MainTabBarController.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "MainTabBarController.h"
#import "AuthManager.h"
#import "LoginViewController.h"
#import "FirebaseManager.h"


@interface MainTabBarController () <LoginViewControllerDelegate>
@end


@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[AuthManager sharedManager] isValidSession]) {
        [self showLoginControllerAnimated:NO];
    }
    else {
        [FirebaseManager sharedManager];
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

- (void)finishAuthFlow
{
    [self setSelectedIndex:0];
    [self dismissViewControllerAnimated:YES completion:nil];
    [FirebaseManager sharedManager];
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewController:(LoginViewController *)loginVC didFoundAuthCode:(NSString *)authCode withState:(NSString *)state
{
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
            [self finishAuthFlow];
        } failure:^(NSError *error) {
            
            STRONGIFY_SELF
            [SVProgressHUD dismiss];
            [self showTryAgainAlertWithMessage:error.localizedDescription];
        }];
    }
    else {
        [self showTryAgainAlertWithMessage:@"Cannot get auth code"];
    }
}

#pragma mark - Public

- (void)performLogout
{
    [self showLoginControllerAnimated:YES];
}


@end
