//
//  UserDefault.h
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Applications.h"

@interface UserDefault : NSObject


-(Applications *) listApplications;
-(void) saveApplications: (Applications *) apps;

@end
