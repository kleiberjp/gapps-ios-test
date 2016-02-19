//
//  ImArtist.h
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Attributes;

@interface ImArtist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) Attributes *attributes;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
