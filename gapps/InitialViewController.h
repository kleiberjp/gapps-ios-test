//
//  ViewController.h
//  gapps
//
//  Created by Kleiber J Perez on 24/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIProgressView *progressLoad;
@property (weak, nonatomic) IBOutlet UILabel *labelProgress;
@property (weak, nonatomic) IBOutlet UILabel *titleProcess;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic) float progressValue;

@end

