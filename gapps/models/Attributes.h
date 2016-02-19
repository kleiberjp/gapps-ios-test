//
//  Attributes.h
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Attributes : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *rel;
@property (nonatomic, strong) NSString *href;
@property (nonatomic, strong) NSString *imBundleId;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *imId;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *term;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
