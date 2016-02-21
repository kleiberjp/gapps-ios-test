//
//  ViewController.m
//  gapps
//
//  Created by Kleiber J Perez on 24/01/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "InitialViewController.h"
#import "GARequestServices.h"
#import "NSString+StringExtension.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Functions Generic App

-(void) setupComponent{
    self.progressValue = 0.0f;
    [self.progressLoad setProgress:0 animated:YES];
    GARequestServices *request = [[GARequestServices alloc] initWithSuperView:self];
    if ([request.userDefaults listApplications].entry.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [request downLoadApplications:^(NSProgress *downloadProgress) {
                self.labelProgress.text = [NSString stringWithFormat:@"%.0f%%", downloadProgress.fractionCompleted*100];
                [self.progressLoad setProgress:downloadProgress.fractionCompleted animated:YES];
            } success:^(BOOL success) {
                if (success) {
                    [self setProgressElement];
                }
            }];
        });
    }else{
        [self setProgressElement];
    }
}

-(void) setProgressElement{
    self.titleProcess.text = [NSString getMessageText:@"title-process"];
    self.labelProgress.text = @"0 %";
    [self.progressLoad setProgress:0 animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(increaseProgresValue) userInfo:nil repeats:NO];
}


-(void) increaseProgresValue{
    if (self.progressLoad.progress < 1) {
        self.progressValue +=0.1;
        self.labelProgress.text = [NSString stringWithFormat:@"%.0f%%", self.progressValue*100];
        [self.progressLoad setProgress:self.progressValue animated:YES];
        [self performSelector:@selector(increaseProgresValue) withObject:self afterDelay:0.2];
    }else{
        [self animateDissapear];
    }
}

- (void) animateDissapear{
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.titleProcess.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.titleProcess.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                          }];
                     }
     ];
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.progressLoad.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4 animations:^{
                             self.progressLoad.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                         }];
                     }
     ];
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.labelProgress.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  self.labelProgress.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                              }
                                              completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.6
                                                                   animations:^{
                                                                       self.iconView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       [UIView animateWithDuration:0.4
                                                                                        animations:^{
                                                                                            self.iconView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            [self performSegueWithIdentifier:@"goToMain" sender:self];
                                                                                        }
                                                                        ];
                                                      
                                                                   }
                                                   ];
                                                }
                              ];
                     }
     ];
}

@end
