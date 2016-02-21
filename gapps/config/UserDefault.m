//
//  UserDefault.m
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "UserDefault.h"
#import "NSString+StringExtension.h"
@import RNCryptor;

@implementation UserDefault

static NSString *APPLICATIONS = @"GA_UD_APPLICATIONS";
static NSString *passwordEncrypt = @"xKMmYgwDcMq00K5I";

-(Applications *)listApplications{
    NSUserDefaults *user_defaults = [self getUserDefaults];
    NSData *data = [user_defaults objectForKey:APPLICATIONS];
    Applications *items = [[Applications alloc] init];
    if (data != nil){
        data = [RNCryptor decryptData:data password:passwordEncrypt error:nil];
        items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return items;
}


-(void)saveApplications:(Applications *)apps{
    NSData *listObject = [NSKeyedArchiver archivedDataWithRootObject:apps];
    listObject = [RNCryptor encryptData:listObject password:passwordEncrypt];
    NSUserDefaults *user_defaults = [self getUserDefaults];
    [user_defaults setObject:listObject forKey:APPLICATIONS];
    [user_defaults synchronize];
}


-(NSUserDefaults *)getUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return userDefaults;
}

@end
