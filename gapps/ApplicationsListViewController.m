//
//  ApplicationsListViewController.m
//  gapps
//
//  Created by Kleiber J Perez on 19/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "ApplicationsListViewController.h"
#import "AppItemCell.h"
#import "AppItem.h"
#import <ChameleonFramework/Chameleon.h>
#import "DetailsViewController.h"
#import "NSString+StringExtension.h"
#import "UserDefault.h"

@implementation ApplicationsListViewController

-(void) viewDidLoad{
    [self setComponents];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userDefaults = [[UserDefault alloc] init];
    self.apps = [self.userDefaults listApplications];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.apps != nil && self.apps.entry.count != 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - Generic Methods
-(void) setComponents{
    self.tableView.layer.masksToBounds = YES;
    self.tableView.clipsToBounds = YES;
    self.tableView.backgroundColor = [UIColor flatWhiteColor];
    self.appsShown = [NSMutableSet set];
    self.navigationController.navigationBar.barTintColor = [UIColor flatGreenColor];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"Raleway-Medium" size:21.0], NSFontAttributeName, nil]];
    [self.navigationItem setTitle:[NSString getMessageText:@"title-list"]];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apps.entry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"AppItem";
    
    AppItemCell *cell = (AppItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    [cell setupDataFromItem:(AppItem *)[self.apps.entry objectAtIndex:indexPath.row] updatedItem:^(AppItem *itemupdated) {
        if (itemupdated) {
            NSMutableArray *itemsNew = [self.apps.entry mutableCopy];
            [itemsNew replaceObjectAtIndex:indexPath.row withObject:itemupdated];
            self.apps.entry = [itemsNew copy];
        }
    }];
    cell.btnOpenOnItunes.tag = indexPath.row;
    cell.btnViewDetails.tag = indexPath.row;
    [cell.btnViewDetails addTarget:self action:@selector(viewDetails:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.appsShown containsObject:indexPath]) {
        [self.appsShown addObject:indexPath];
        cell.alpha = 0.7;
        
        CATransform3D rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0);
        cell.layer.transform = rotationTransform;
        
        [UIView animateWithDuration:1.0 animations:^{
            
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1;
            
        }];
    }
}

#pragma mark - Navigations

-(void)viewDetails:(UIButton *)sender{
    [self performSegueWithIdentifier:@"goToDetails" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToDetails"]){
        AppItem *item = [self.apps.entry objectAtIndex:[(UIButton *)sender tag]];
        DetailsViewController *detailsVC  = segue.destinationViewController;
        detailsVC.item = item;
        [self.userDefaults saveApplications:self.apps];
    }
}

@end
