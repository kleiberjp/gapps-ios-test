//
//  Entry.h
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImContentType, Rights, CategoryItem, IdClass, ImPrice, Link, ImArtist, ImName, Title, Summary, ImReleaseDate;

@interface Entry : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ImContentType *imContentType;
@property (nonatomic, strong) Rights *rights;
@property (nonatomic, strong) CategoryItem *category;
@property (nonatomic, strong) IdClass *entryIdentifier;
@property (nonatomic, strong) NSArray *imImage;
@property (nonatomic, strong) ImPrice *imPrice;
@property (nonatomic, strong) Link *link;
@property (nonatomic, strong) ImArtist *imArtist;
@property (nonatomic, strong) ImName *imName;
@property (nonatomic, strong) Title *title;
@property (nonatomic, strong) Summary *summary;
@property (nonatomic, strong) ImReleaseDate *imReleaseDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
