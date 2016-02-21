//
//  AppItemCell.h
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppItem.h"
#import "BFPaperButton.h"

@interface AppItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *appIconPreview;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appArtist;
@property (weak, nonatomic) IBOutlet UILabel *appPrice;
@property (weak, nonatomic) IBOutlet UILabel *appReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *appCategory;
@property (retain, nonatomic) IBOutlet BFPaperButton *btnOpenOnItunes;
@property (retain, nonatomic) IBOutlet BFPaperButton *btnViewDetails;

-(void) setupDataFromItem:(AppItem *)item updatedItem:(void (^)(AppItem *itemupdated))update;

@end
