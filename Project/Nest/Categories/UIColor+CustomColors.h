//
//  UIColor+CustomColors.h
//  Nest
//
//  Created by ivanSamalazau on 22.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColors)

+ (instancetype)colorWithRGBHex:(long)code;
+ (instancetype)colorWithRGBHex:(long)code alpha:(float)alpha;

+ (instancetype)customRedColor;
+ (instancetype)customGreenColor;

@end
