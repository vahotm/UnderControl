//
//  Devices.h
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//

#import "BaseModel.h"


@class Thermostat;
@interface Devices : BaseModel

@property (nonatomic, strong) NSArray<Thermostat *> *thermostats;
//@property (nonatomic, strong) NSArray *smokeAlarms;
//@property (nonatomic, strong) NSArray *cameras;

@end
