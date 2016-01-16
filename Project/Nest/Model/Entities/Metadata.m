//
//  Metadata.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "Metadata.h"

@implementation Metadata

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"accessToken" : @"access_token",
             @"clientVersion" : @"client_version"
             };
}

@end
