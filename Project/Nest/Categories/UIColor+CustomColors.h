//
//  UIColor+CustomColors.h
//  Nest
//
//  Created by ivanSamalazau on 22.1.16.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColors)

+ (instancetype)colorWithRGBHex:(long)code;
+ (instancetype)colorWithRGBHex:(long)code alpha:(float)alpha;

+ (instancetype)customRedColor;
+ (instancetype)customGreenColor;

@end
