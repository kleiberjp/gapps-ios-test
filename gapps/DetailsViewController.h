//
//  DetailsViewController.h
//  gapps
//
//  Created by Kleiber J Perez on 20/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppItem.h"
#import "BFPaperButton.h"

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) AppItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *appImgPreview;
@property (weak, nonatomic) IBOutlet UILabel *appArtist;
@property (weak, nonatomic) IBOutlet UILabel *appCathegory;
@property (weak, nonatomic) IBOutlet UILabel *appPrice;
@property (weak, nonatomic) IBOutlet UILabel *appDescription;
@property (weak, nonatomic) IBOutlet UILabel *appRights;
@property (retain, nonatomic) IBOutlet BFPaperButton *btnOpenOnItunes;


@end
