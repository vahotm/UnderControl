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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Away status: %@", [structure awayStatusStringRepresentation]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Structure *structure = self.structures[indexPath.row];
    ThermostatsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ThermostatsTableViewController"];
    vc.thermostats = structure.thermostats;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
