//
//  ProfileViewController.m
//  Nest
//
//  Created by ivanSamalazau on 15.1.16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "ProfileViewController.h"
#import "AuthManager.h"
#import "MainTabBarController.h"


NSString *const kCellReuseId = @"ReuseId";


typedef NS_ENUM(NSInteger, ProfileCell) {
    ProfileCellLogout,
};


@interface ProfileViewController ()
@end


@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self cellDescriptorsForSection:section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellForDescriptor:[self cellDescriptorForIndexPath:indexPath]
                       inTableView:tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProfileCell descriptor = [self cellDescriptorForIndexPath:indexPath];
    switch (descriptor) {
        case ProfileCellLogout: {
            [[AuthManager sharedManager] logout];
            MainTabBarController *mainTabBarController = (MainTabBarController *)self.tabBarController;
            [mainTabBarController performLogout];
            break;
        }
    }
}

#pragma mark - Cells

- (NSArray *)cellDescriptorsForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @[@(ProfileCellLogout)];
            break;
            
        default:
            break;
    }
    return @[];
}

- (UITableViewCell *)cellForDescriptor:(ProfileCell)descriptor inTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseId];
    
    switch (descriptor) {
        case ProfileCellLogout: {
            cell.textLabel.text = @"Logout";
            
            break;
        }
    }
    return cell;
}

- (ProfileCell)cellDescriptorForIndexPath:(NSIndexPath *)indexPath
{
    return [[self cellDescriptorsForSection:indexPath.section][indexPath.row] integerValue];
}



@end
