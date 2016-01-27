//
//  UIViewController+Alerts.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   okTitle:(NSString *)okTitle
                   okBlock:(void (^)())okBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:
                               ^(UIAlertAction * _Nonnull action) {
                                   if (nil != okBlock) {
                                       okBlock();
                                   }
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    [self showAlertWithTitle:@"Error"
                     message:message
                     okTitle:@"Cancel"
                     okBlock:nil];
}

@end
