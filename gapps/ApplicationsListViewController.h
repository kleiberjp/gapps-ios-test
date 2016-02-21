//
//  ApplicationsListViewController.h
//  gapps
//
//  Created by Kleiber J Perez on 19/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Applications.h"
#import "UserDefault.h"

@interface ApplicationsListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) Applications *apps;
@property (nonatomic, strong) NSMutableSet *appsShown;
@property (nonatomic, retain) UserDefault *userDefaults;

@end
