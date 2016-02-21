//
//  AppItemCell.m
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "AppItemCell.h"
#import <ChameleonFramework/Chameleon.h>
#import "ColorPallete.h"
#import "NSString+StringExtension.h"
#import "GARequestServices.h"
#import "UserDefault.h"

@implementation AppItemCell

static CGFloat cornerRadius = 3;


-(void)layoutSubviews{
    self.mainView.layer.cornerRadius = cornerRadius;
    self.mainView.layer.masksToBounds = NO;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 3);
    self.mainView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.mainView.layer.shadowOpacity = 0.5f;
    self.mainView.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.mainView.bounds cornerRadius:cornerRadius] CGPath];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self imageSetup];
}

#pragma mark - Setup Elements

-(void) imageSetup{
    self.appIconPreview.layer.cornerRadius = self.appIconPreview.frame.size.width/5;
    self.appIconPreview.clipsToBounds = YES;
    self.appIconPreview.contentMode = UIViewContentModeScaleAspectFit;
    self.appIconPreview.backgroundColor = [UIColor whiteColor];
}

-(void)setupDataFromItem:(AppItem *)item updatedItem:(void (^)(AppItem *))update{
    AppItem *updatedItem = item;
    if (item.imageApp) {
        self.appIconPreview.image = item.imageApp;
    }else{
        ImImage *image = [item.imImage lastObject];
        
        [[[GARequestServices alloc] init] downloadImage:image.label andSetAtCell:self success:^(UIImage *image) {
            updatedItem.imageApp = image;
        }];
    }
    self.backgroundColor = [UIColor flatWhiteColor];
    self.appName.text = item.imName.label;
    self.appArtist.text = item.imArtist.label;
    self.appPrice.text = ([item.imPrice.attributes.amount doubleValue] == 0) ? [NSString getMessageText:@"free"] : item.imPrice.attributes.amount;
    self.appReleaseDate.text = item.imReleaseDate.attributes.label;
    self.appCategory.text = item.category.attributes.label;
    
    self.btnOpenOnItunes = [[BFPaperButton alloc] initWithFrame:CGRectMake(self.appIconPreview.frame.origin.x + 20, self.appIconPreview.frame.size.height + 30, (self.frame.size.width/2) - (self.appIconPreview.frame.origin.x + 20)*2 , 36) raised:YES];
    [self.btnOpenOnItunes setTitle:[NSString getMessageText:@"btn-itunes"] forState:UIControlStateNormal];
    self.btnOpenOnItunes.backgroundColor = [UIColor flatWhiteColor];  // This is from the included cocoapod "UIColor+BFPaperColors".
    [self.btnOpenOnItunes setTitleColor:[UIColor flatGrayColor] forState:UIControlStateNormal];
    [self.btnOpenOnItunes setTitleColor:[UIColor flatGrayColorDark] forState:UIControlStateHighlighted];
    [self.btnOpenOnItunes addTarget:self action:@selector(openAppInItunes:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnViewDetails = [[BFPaperButton alloc] initWithFrame:CGRectMake((self.frame.size.width/2) + 20, self.btnOpenOnItunes.frame.origin.y, self.btnOpenOnItunes.frame.size.width, self.btnOpenOnItunes.frame.size.height) raised:YES];
    [self.btnViewDetails setTitle:[NSString getMessageText:@"btn-details"] forState:UIControlStateNormal];
    self.btnViewDetails.backgroundColor = [UIColor flatGreenColor];
    [self.btnViewDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnViewDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self addSubview:self.btnOpenOnItunes];
    [self addSubview:self.btnViewDetails];
    
    if (update && updatedItem.imageApp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            update(updatedItem);
        });
    }
}

#pragma mark - Actions Buttons

- (void)openAppInItunes:(UIButton *)sender
{
    AppItem *item = [[[[UserDefault alloc] init] listApplications].entry objectAtIndex:sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.entryIdentifier.label]];
}
@end
