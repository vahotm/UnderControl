//
//  State.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "State.h"
#import "Metadata.h"
#import "Devices.h"
#import "Structure.h"
#import "Thermostat.h"
#import "DeviceLocation.h"

#import "MTLJSONAdapter+Utils.h"


@implementation State

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"metadata" : @"metadata",
             @"devices" : @"devices",
             @"structures" : @"structures",
             };
}

+ (NSValueTransformer *)metadataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[Metadata class]];
}

+ (NSValueTransformer *)devicesJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[Devices class]];
}

+ (NSValueTransformer *)structuresJSONTransformer
{
    return [MTLJSONAdapter pseudoArrayTransformerWithModelClass:[Structure class] idKeyPath:@"structure_id"];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    
    //  Fill devices array by provided ids
    for (Structure *structure in self.structures) {
        structure.thermostats = [self.devices.thermostats filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Thermostat *_Nonnull thermostat, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [structure.thermostatsIds containsObject:thermostat.deviceId];
        }]];
        
        //  Fill devices "where" field
        for (Thermostat *thermostat in structure.thermostats) {
            NSArray *foundLocations = [structure.locations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DeviceLocation *_Nonnull location, NSDictionary<NSString *,id> * _Nullable bindings) {
                return [location.whereId isEqualToString:thermostat.locationId];
            }]];
            DeviceLocation *location = [foundLocations firstObject];
            if (location != nil) {
                thermostat.location = location;
            }
        }
    }
    
    return self;
}



@end
