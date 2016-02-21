//
//  NSString+StringExtension.m
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "NSString+StringExtension.h"

@implementation NSString (StringExtension)

-(NSString *) getMessage {
    
    return NSLocalizedString(self, self);
}

+(NSString *) getMessageText: (NSString *) findMessage {
    return NSLocalizedString(findMessage, findMessage);
}

+(NSString *) getMessageTextError:(NSString *)findMessage{
    return [[NSString alloc] initWithFormat:@"* %@", NSLocalizedString(findMessage, findMessage)];
}

@end
