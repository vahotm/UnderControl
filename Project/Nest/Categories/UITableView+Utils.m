//
//  UITableView+Utils.m
//  Nest
//
//  Created by ivanSamalazau on 22.1.16.
//

#import "UITableView+Utils.h"

@implementation UITableView (Utils)

- (void)hideEmptySeparators
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

@end
