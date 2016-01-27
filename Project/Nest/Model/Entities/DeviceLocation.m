//
//  DeviceLocation.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "DeviceLocation.h"

@implementation DeviceLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"name" : @"name",
             @"whereId" : @"where_id"};
}

@end
