//
//  ThermostatsTableViewController.h
//  Nest
//
//  Created by ivanSamalazau on 16.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structure.h"


@class Thermostat;
@interface ThermostatsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray<Thermostat *> *thermostats;
@property (nonatomic, assign) StructureAwayStatus awayStatus;

@end
