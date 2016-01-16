//
//  Structure.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "BaseModel.h"


typedef NS_ENUM(NSInteger, StructureAwayStatus) {
    StructureAwayStatusHome,
    StructureAwayStatusAway,
    StructureAwayStatusAutoAway,
};


@class DeviceLocation;
@class Thermostat;
@interface Structure : BaseModel

@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, assign) StructureAwayStatus awayStatus;

//@property (nonatomic, strong) NSArray<NSString *> *camerasIds;
//@property (nonatomic, strong) NSArray<NSString *> *smokeAlarmsIds;
@property (nonatomic, strong) NSArray<NSString *> *thermostatsIds;

@property (nonatomic, strong) NSArray<Thermostat *> *thermostats;
@property (nonatomic, strong) NSArray<DeviceLocation *> *locations;

- (NSString *)awayStatusStringRepresentation;

@end
