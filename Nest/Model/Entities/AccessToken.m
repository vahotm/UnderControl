//
//  AccessToken.m
//  Nest
//
//  Created by ivanSamalazau on 14.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"token": @"access_token",
             @"expireDate": @"expire_date"};
}

#pragma mark - Init

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.token = dict[@"access_token"];
        self.expireDate = [NSDate dateWithTimeIntervalSinceNow:[dict[@"expires_in"] longValue]];
    }
    return self;
}

- (BOOL)isValid
{
    return ([self.expireDate compare:[NSDate date]] == NSOrderedDescending &&
            self.token != nil);
}

@end
