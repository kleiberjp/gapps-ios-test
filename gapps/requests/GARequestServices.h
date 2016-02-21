//
//  GARequestServices.h
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefault.h"
#import <UIKit/UIKit.h>

@class AppItemCell;

@interface GARequestServices : NSObject

@property (nonatomic, retain) UIViewController *superView;
@property(retain, nonatomic) UserDefault  *userDefaults;

-(instancetype) initWithSuperView:(UIViewController *) view;
-(void) downLoadApplications:(void (^)(NSProgress *downloadProgress)) progress success:(void (^)(BOOL success)) success;
-(void)downloadImage:(NSString *)ulr andSetAtCell:(AppItemCell *)cellApp success:(void (^)(UIImage *image))successFully;


@end
