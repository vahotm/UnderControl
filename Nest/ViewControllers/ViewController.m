//
//  ViewController.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "AuthManager.h"
#import "UIViewController+Alerts.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>


@interface ViewController () <LoginViewControllerDelegate>
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)onLogin:(UIButton *)sender
{
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginVC.authURL = [AuthManager authorizationURL];
    loginVC.redirectURL = [AuthManager redirectURL];
    loginVC.delegate = self;
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewController:(LoginViewController *)loginVC didFoundAuthCode:(NSString *)authCode withState:(NSString *)state
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([state isEqualToString:[AuthManager state]] &&
        authCode != nil)
    {
        AuthManager *authManager = [AuthManager sharedManager];
        authManager.authCode = authCode;
        
        [SVProgressHUD showWithStatus:@"Authenticating"];
        [authManager requestAuthTokenWithSuccess:^(NSString *authToken) {
            
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            [self showErrorAlertWithMessage:error.localizedDescription];
        }];
    }
    else {
        [self showErrorAlertWithMessage:@"Cannot get auth code"];
    }
}

- (void)loginViewControllerDidCancelRequest:(LoginViewController *)loginVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
