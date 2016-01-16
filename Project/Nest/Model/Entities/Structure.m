//
//  Structure.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "Structure.h"
#import "DeviceLocation.h"

#import "MTLJSONAdapter+Utils.h"


@implementation Structure

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"structureId" : @"structure_id",
             @"name" : @"name",
             @"countryCode" : @"country_code",
             @"timeZone" : @"time_zone",
             @"awayStatus" : @"away",
//             @"camerasIds" : @"cameras",
//             @"smokeAlarmsIds" : @"smoke_co_alarms",
             @"thermostatsIds" : @"thermostats",
             @"locations" : @"wheres",
             };
}

+ (NSValueTransformer *)locationsJSONTransformer
{
    return [MTLJSONAdapter pseudoArrayTransformerWithModelClass:[DeviceLocation class] idKeyPath:@"where_id"];
}

+ (NSValueTransformer *)awayStatusJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        StructureAwayStatus status = StructureAwayStatusHome;
        if ([value isEqualToString:@"home"]) {
            status = StructureAwayStatusHome;
        }
        else if ([value isEqualToString:@"away"]) {
            status = StructureAwayStatusAway;
        }
        else if ([value isEqualToString:@"auto-away"]) {
            status = StructureAwayStatusAutoAway;
        }
        return @(status);
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        StructureAwayStatus status = [value integerValue];
        NSString *string = nil;
        switch (status) {
            case StructureAwayStatusHome: {
                string = @"home";
                break;
            }
            case StructureAwayStatusAway: {
                string = @"away";
                break;
            }
            case StructureAwayStatusAutoAway: {
                string = @"auto-away";
                break;
            }
        }
        return string;
    }];
}

#pragma mark - Public

- (NSString *)awayStatusStringRepresentation
{
    NSString *string = nil;
    switch (self.awayStatus) {
        case StructureAwayStatusHome: {
            string = @"At home";
            break;
        }
        case StructureAwayStatusAway: {
            string = @"Away";
            break;
        }
        case StructureAwayStatusAutoAway: {
            string = @"Auto-away";
            break;
        }
    }
    return string;
}


@end
