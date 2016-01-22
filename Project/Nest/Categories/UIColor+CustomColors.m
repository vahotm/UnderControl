//
//  UIColor+CustomColors.m
//  Nest
//
//  Created by ivanSamalazau on 22.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (instancetype)customRedColor
{
    return [self colorWithRed:0.9 green:0.2 blue:0.3 alpha:1];
}

+ (instancetype)customGreenColor
{
    return [self colorWithRed:0.3 green:0.8 blue:0.3 alpha:1];
}

@end
