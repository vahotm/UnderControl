//
//  ThermostatsTableViewController.h
//  Nest
//
//  Created by ivanSamalazau on 16.1.16.
//

#import <UIKit/UIKit.h>
#import "Structure.h"


@class Thermostat;
@interface ThermostatsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray<Thermostat *> *thermostats;
@property (nonatomic, assign) StructureAwayStatus awayStatus;

@end
