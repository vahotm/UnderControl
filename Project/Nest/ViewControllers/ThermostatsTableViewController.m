//
//  ThermostatsTableViewController.m
//  Nest
//
//  Created by ivanSamalazau on 16.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "ThermostatsTableViewController.h"
#import "Thermostat.h"
#import "ThermostatDetailsViewController.h"


NSString *const kThermostatsCellReuseId = @"CellReuseId";


@interface ThermostatsTableViewController ()

@end


@implementation ThermostatsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.thermostats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kThermostatsCellReuseId forIndexPath:indexPath];
    Thermostat *thermostat = self.thermostats[indexPath.row];
    
    cell.textLabel.text = thermostat.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f %@", [thermostat ambientTemperature], [thermostat stringFromTemperatureScale]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Thermostat *thermostat = self.thermostats[indexPath.row];
    ThermostatDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ThermostatDetailsViewController"];
    vc.thermostatId = thermostat.deviceId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
