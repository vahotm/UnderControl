//
//  UIViewController+Alerts.h
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   okTitle:(NSString *)okTitle
                   okBlock:(void (^)())okBlock;

- (void)showErrorAlertWithMessage:(NSString *)message;

@end
