//
//  Devices.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "Devices.h"
#import "Thermostat.h"

#import "MTLJSONAdapter+Utils.h"


@implementation Devices

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"thermostats" : @"thermostats",
//             @"smokeAlarms" : @"smoke_co_alarms",
//             @"cameras" : @"cameras",
             };
}

+ (NSValueTransformer *)thermostatsJSONTransformer
{
    return [MTLJSONAdapter pseudoArrayTransformerWithModelClass:[Thermostat class] idKeyPath:@"device_id"];
}

//+ (NSValueTransformer *)smokeAlarmsJSONTransformer
//{
//    return [MTLValueTransformer transformerForPseudoArrayWithModelClass:[Thermostat class] idKey:@"device_id"];
//}
//
//+ (NSValueTransformer *)camerasJSONTransformer
//{
//    return [MTLValueTransformer transformerForPseudoArrayWithModelClass:[Thermostat class] idKey:@"device_id"];
//}




@end
