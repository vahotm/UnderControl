//
//  StructuresViewController.m
//  Nest
//
//  Created by ivanSamalazau on 16.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "StructuresViewController.h"
#import "FirebaseManager.h"
#import "Structure.h"
#import "State.h"

#import "ThermostatsTableViewController.h"


NSString *const kStructuresCellReuseId = @"CellReuseId";


@interface StructuresViewController ()

@property (nonatomic, strong) NSArray<Structure *> *structures;

@end


@implementation StructuresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kFirebaseDidUpdateStateNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      State *state = note.userInfo[kFirebaseNotificationStateKey];
                                                      self.structures = state.structures;
                                                      [self.tableView reloadData];
                                                  }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.structures.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStructuresCellReuseId forIndexPath:indexPath];
    Structure *structure = self.structures[indexPath.row];
    
    cell.textLabel.text = structure.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [structure awayStatusStringRepresentation]];
    switch (structure.awayStatus) {
        case StructureAwayStatusHome: {
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.3 alpha:1];
            break;
        }
        case StructureAwayStatusAway: {
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.9 green:0.2 blue:0.3 alpha:1];
            break;
        }
        case StructureAwayStatusAutoAway: {
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            break;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Structure *structure = self.structures[indexPath.row];
    ThermostatsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ThermostatsTableViewController"];
    vc.thermostats = structure.thermostats;
    vc.awayStatus = structure.awayStatus;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
