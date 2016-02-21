//
//  NSString+StringExtension.h
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringExtension)

-(NSString *) getMessage;
+(NSString *) getMessageText: (NSString *) findMessage;
+(NSString *) getMessageTextError:(NSString *)findMessage;

@end
