//
//  Thermostat.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "BaseModel.h"


typedef NS_ENUM(NSInteger, TemperatureScale) {
    TemperatureScaleFahrenheit,
    TemperatureScaleCelsius,
};

typedef NS_ENUM(NSInteger, HVACMode) {
    HVACModeOff,
    HVACModeCool,
    HVACModeHeat,
    HVACModeHeatCool,
};

typedef NS_ENUM(NSInteger, HVACState) {
    HVACStateHeating,
    HVACStateCooling,
    HVACStateOff,
};


@class DeviceLocation;
@interface Thermostat : BaseModel

@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *softwareVersion;
@property (nonatomic, strong) NSString *structureId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameLong;
@property (nonatomic, strong) NSDate *lastConnection;
@property (nonatomic, assign) BOOL isOnline;
@property (nonatomic, assign) BOOL canCool;
@property (nonatomic, assign) BOOL canHeat;
@property (nonatomic, assign) BOOL isUsingEmergencyHeat;
@property (nonatomic, assign) BOOL hasFan;
@property (nonatomic, assign) BOOL fanTimerActive;
@property (nonatomic, strong) NSDate *fanTimerTimeout;
@property (nonatomic, assign) BOOL hasLeaf;
@property (nonatomic, assign) float humidity;
@property (nonatomic, assign) TemperatureScale temperatureScale;
@property (nonatomic, assign) float targetTemperatureF;
@property (nonatomic, assign) float targetTemperatureC;
@property (nonatomic, assign) float targetTemperatureHighF;
@property (nonatomic, assign) float targetTemperatureHighC;
@property (nonatomic, assign) float targetTemperatureLowF;
@property (nonatomic, assign) float targetTemperatureLowC;
@property (nonatomic, assign) float awayTemperatureHighF;
@property (nonatomic, assign) float awayTemperatureHighC;
@property (nonatomic, assign) float awayTemperatureLowF;
@property (nonatomic, assign) float awayTemperatureLowC;
@property (nonatomic, assign) HVACMode hvacMode;
@property (nonatomic, assign) float ambientTemperatureF;
@property (nonatomic, assign) float ambientTemperatureC;
@property (nonatomic, assign) HVACState hvacState;
@property (nonatomic, strong) NSString *locationId;

@property (nonatomic, strong) DeviceLocation *location;

- (float)targetTemperature;
- (float)targetTemperatureHigh;
- (float)targetTemperatureLow;
- (float)awayTemperatureHigh;
- (float)awayTemperatureLow;
- (float)ambientTemperature;

- (NSString *)stringFromTemperatureScale;
- (BOOL)hasHeatCool;
- (NSString *)stringFromHVACState;

- (NSDictionary *)dictionaryWithTemperature;
- (NSDictionary *)dictionaryWithHVACMode;


@end
