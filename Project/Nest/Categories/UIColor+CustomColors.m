//
//  UIColor+CustomColors.m
//  Nest
//
//  Created by ivanSamalazau on 22.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (instancetype)colorWithRGBHex:(long)code
{
    return [[self class] colorWithRGBHex:code alpha:1.0];
}

+ (instancetype)colorWithRGBHex:(long)code alpha:(float)alpha
{
    return [UIColor colorWithRed:((float)((code & 0xFF0000) >> 16))/255.0
                           green:((float)((code & 0xFF00) >> 8))/255.0
                            blue:((float)(code & 0xFF))/255.0
                           alpha:alpha];
}

#pragma mark - Colors

+ (instancetype)customRedColor
{
    return [self colorWithRGBHex:0xC41A16];
}

+ (instancetype)customGreenColor
{
    return [self colorWithRGBHex:0x007400];
}

@end
