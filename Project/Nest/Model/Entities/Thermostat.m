//
//  Thermostat.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "Thermostat.h"
#import "NSDateFormatter+ISO8601.h"


@implementation Thermostat

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"deviceId" : @"device_id",
             @"locale" : @"locale",
             @"softwareVersion" : @"software_version",
             @"structureId" : @"structure_id",
             @"name" : @"name",
             @"nameLong" : @"name_long",
             @"lastConnection" : @"last_connection",
             @"isOnline" : @"is_online",
             @"canCool" : @"can_cool",
             @"canHeat" : @"can_heat",
             @"isUsingEmergencyHeat" : @"is_using_emergency_heat",
             @"hasFan" : @"has_fan",
             @"fanTimerActive" : @"fan_timer_active",
             @"fanTimerTimeout" : @"fan_timer_timeout",
             @"hasLeaf" : @"has_leaf",
             @"temperatureScale" : @"temperature_scale",
             @"targetTemperatureF" : @"target_temperature_f",
             @"targetTemperatureC" : @"target_temperature_c",
             @"targetTemperatureHighF" : @"target_temperature_high_f",
             @"targetTemperatureHighC" : @"target_temperature_high_c",
             @"targetTemperatureLowF" : @"target_temperature_low_f",
             @"targetTemperatureLowC" : @"target_temperature_low_c",
             @"awayTemperatureHighF" : @"away_temperature_high_f",
             @"awayTemperatureHighC" : @"away_temperature_high_c",
             @"awayTemperatureLowF" : @"away_temperature_low_f",
             @"awayTemperatureLowC" : @"away_temperature_low_c",
             @"hvacMode" : @"hvac_mode",
             @"ambientTemperatureF" : @"ambient_temperature_f",
             @"ambientTemperatureC" : @"ambient_temperature_c",
             @"humidity" : @"humidity",
             @"hvacState" : @"hvac_state",
             @"locationId" : @"where_id",
             };
}

+ (NSValueTransformer *)temperatureScaleJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        TemperatureScale scale = TemperatureScaleCelsius;
        if ([value isEqualToString:@"C"]) {
            scale = TemperatureScaleCelsius;
        }
        else if ([value isEqualToString:@"F"]) {
            scale = TemperatureScaleFahrenheit;
        }
        return @(scale);
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        TemperatureScale scale = [value integerValue];
        NSString *string = nil;
        switch (scale) {
            case TemperatureScaleFahrenheit: {
                string = @"F";
                break;
            }
            case TemperatureScaleCelsius: {
                string = @"C";
                break;
            }
        }
        return string;
    }];
}

+ (NSValueTransformer *)hvacModeJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        HVACMode mode = HVACModeOff;
        if ([value isEqualToString:@"heat"]) {
            mode = HVACModeHeat;
        }
        else if ([value isEqualToString:@"cool"]) {
            mode = HVACModeCool;
        }
        else if ([value isEqualToString:@"heat-cool"]) {
            mode = HVACModeHeatCool;
        }
        else if ([value isEqualToString:@"off"]) {
            mode = HVACModeOff;
        }
        return @(mode);
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        HVACMode mode = [value integerValue];
        NSString *string = nil;
        switch (mode) {
            case HVACModeHeat: {
                string = @"heat";
                break;
            }
            case HVACModeCool: {
                string = @"cool";
                break;
            }
            case HVACModeHeatCool: {
                string = @"heat-cool";
                break;
            }
            case HVACModeOff: {
                string = @"off";
                break;
            }
        }
        return string;
    }];
}

+ (NSValueTransformer *)hvacStateJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        HVACState state = HVACStateOff;
        if ([value isEqualToString:@"heating"]) {
            state = HVACStateHeating;
        }
        else if ([value isEqualToString:@"cooling"]) {
            state = HVACStateCooling;
        }
        else if ([value isEqualToString:@"off"]) {
            state = HVACStateOff;
        }
        return @(state);
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        HVACState state = [value integerValue];
        NSString *string = nil;
        switch (state) {
            case HVACStateHeating: {
                string = @"heating";
                break;
            }
            case HVACStateCooling: {
                string = @"cooling";
                break;
            }
            case HVACStateOff: {
                string = @"off";
                break;
            }
        }
        return string;
    }];
}

+ (NSValueTransformer *)lastConnectionJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[NSDateFormatter ISO8601Formatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[NSDateFormatter ISO8601Formatter] stringFromDate:date];
    }];
}

+ (NSValueTransformer *)fanTimerTimeoutJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[NSDateFormatter ISO8601Formatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[NSDateFormatter ISO8601Formatter] stringFromDate:date];
    }];
}

+ (NSValueTransformer *)isOnlineJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)canCoolJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)canHeatJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)isUsingEmergencyHeatJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)hasFanJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)fanTimerActiveJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)hasLeafJSONTransformer
{
    return [MTLValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

#pragma mark - Public

- (float)targetTemperature
{
    return [self temperatureWithFTemp:self.targetTemperatureF
                                CTemp:self.targetTemperatureC];
}

- (float)targetTemperatureHigh
{
    return [self temperatureWithFTemp:self.targetTemperatureHighF
                                CTemp:self.targetTemperatureHighC];
}

- (float)targetTemperatureLow
{
    return [self temperatureWithFTemp:self.targetTemperatureLowF
                                CTemp:self.targetTemperatureLowC];
}

- (float)awayTemperatureHigh;
{
    return [self temperatureWithFTemp:self.awayTemperatureHighF
                                CTemp:self.awayTemperatureHighC];
}

- (float)awayTemperatureLow
{
    return [self temperatureWithFTemp:self.awayTemperatureLowF
                                CTemp:self.awayTemperatureLowC];
}

- (float)ambientTemperature
{
    return [self temperatureWithFTemp:self.ambientTemperatureF
                                CTemp:self.ambientTemperatureC];
}

- (NSString *)stringFromTemperatureScale
{
    NSString *string = nil;
    switch (self.temperatureScale) {
        case TemperatureScaleFahrenheit: {
            string = @"F";
            break;
        }
        case TemperatureScaleCelsius: {
            string = @"C";
            break;
        }
    }
    return string;
}

- (float)temperatureWithFTemp:(float)fTemp CTemp:(float)cTemp
{
    switch (self.temperatureScale) {
        case TemperatureScaleFahrenheit: {
            return fTemp;
        }
        case TemperatureScaleCelsius: {
            return cTemp;
        }
    }
}

- (BOOL)hasHeatCool
{
    return (self.canCool &&
            self.canHeat);
}

- (NSString *)stringFromHVACState
{
    NSString *string = nil;
    switch (self.hvacState) {
        case HVACStateHeating: {
            string = @"heating";
            break;
        }
        case HVACStateCooling: {
            string = @"cooling";
            break;
        }
        case HVACStateOff: {
            string = @"off";
            break;
        }
    }
    return string;
}

- (NSDictionary *)dictionaryWithTemperature
{
    NSDictionary *dict = nil;
    switch (self.hvacMode) {
        case HVACModeOff: {
            break;
        }
        case HVACModeCool:
        case HVACModeHeat: {
            if (self.temperatureScale == TemperatureScaleCelsius) {
                dict = @{@"target_temperature_c" : @(self.targetTemperatureC),
                         };
            }
            else {
                dict = @{@"target_temperature_f" : @(self.targetTemperatureF),
                         };
            }
            break;
        }
        case HVACModeHeatCool: {
            if (self.temperatureScale == TemperatureScaleCelsius) {
                dict = @{@"target_temperature_high_c" : @(self.targetTemperatureHighC),
                         @"target_temperature_low_c" : @(self.targetTemperatureLowC),
                         };
            }
            else {
                dict = @{@"target_temperature_high_f" : @(self.targetTemperatureHighF),
                         @"target_temperature_low_f" : @(self.targetTemperatureLowF),
                         };
            }
            break;
        }
    }
    return dict;
}

- (NSDictionary *)dictionaryWithHVACMode
{
    return @{@"hvac_mode" : [[self.class hvacModeJSONTransformer] reverseTransformedValue:@(self.hvacMode)]
             };
}

#pragma mark - Properties

- (void)setTargetTemperatureC:(float)targetTemperatureC
{
    _targetTemperatureC = [self roundFloat:targetTemperatureC];
}

- (void)setTargetTemperatureF:(float)targetTemperatureF
{
    _targetTemperatureF = [self roundFloat:targetTemperatureF];
}

- (void)setTargetTemperatureHighC:(float)targetTemperatureHighC
{
    _targetTemperatureHighC = [self roundFloat:targetTemperatureHighC];
}

- (void)setTargetTemperatureHighF:(float)targetTemperatureHighF
{
    _targetTemperatureHighF = [self roundFloat:targetTemperatureHighF];
}

- (void)setTargetTemperatureLowC:(float)targetTemperatureLowC
{
    _targetTemperatureLowC = [self roundFloat:targetTemperatureLowC];
}

- (void)setTargetTemperatureLowF:(float)targetTemperatureLowF
{
    _targetTemperatureLowF = [self roundFloat:targetTemperatureLowF];
}

- (float)roundFloat:(float)value
{
    float roundedValue = roundf(value);
    if (roundedValue > value) {
        float halfCandidate = roundedValue - 0.5;
        if (roundedValue - value > value - halfCandidate) {
            return halfCandidate;
        }
        else {
            return roundedValue;
        }
    }
    else if (roundedValue < value) {
        float halfCandidate = roundedValue + 0.5;
        if (value - roundedValue > halfCandidate - value) {
            return halfCandidate;
        }
        else {
            return roundedValue;
        }
    }
    return value;
}


@end
