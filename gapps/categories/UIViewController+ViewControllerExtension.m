//
//  UIViewController+ViewControllerExtension.m
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "UIViewController+ViewControllerExtension.h"

@implementation UIViewController (ViewControllerExtension)

-(void) showAlert:(NSString *) title withMessage:(NSString *) message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      [alertController dismissViewControllerAnimated:YES
                                                                                          completion:nil];
                                                  }];
    
    [alertController addAction:alert];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
