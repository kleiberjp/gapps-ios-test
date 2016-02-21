//
//  Entry.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AppItem.h"

NSString *const kEntryImContentType = @"im:contentType";
NSString *const kEntryRights = @"rights";
NSString *const kEntryCategory = @"category";
NSString *const kEntryId = @"id";
NSString *const kEntryImImage = @"im:image";
NSString *const kEntryImPrice = @"im:price";
NSString *const kEntryLink = @"link";
NSString *const kEntryImArtist = @"im:artist";
NSString *const kEntryImName = @"im:name";
NSString *const kEntryTitle = @"title";
NSString *const kEntrySummary = @"summary";
NSString *const kEntryImReleaseDate = @"im:releaseDate";


@interface AppItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AppItem


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imContentType = [ImContentType modelObjectWithDictionary:[dict objectForKey:kEntryImContentType]];
            self.rights = [Rights modelObjectWithDictionary:[dict objectForKey:kEntryRights]];
            self.category = [CategoryItem modelObjectWithDictionary:[dict objectForKey:kEntryCategory]];
            self.entryIdentifier = [IdClass modelObjectWithDictionary:[dict objectForKey:kEntryId]];
    NSObject *receivedImImage = [dict objectForKey:kEntryImImage];
    NSMutableArray *parsedImImage = [NSMutableArray array];
    if ([receivedImImage isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedImImage) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedImImage addObject:[ImImage modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedImImage isKindOfClass:[NSDictionary class]]) {
       [parsedImImage addObject:[ImImage modelObjectWithDictionary:(NSDictionary *)receivedImImage]];
    }

    self.imImage = [NSArray arrayWithArray:parsedImImage];
            self.imPrice = [ImPrice modelObjectWithDictionary:[dict objectForKey:kEntryImPrice]];
            self.link = [Link modelObjectWithDictionary:[dict objectForKey:kEntryLink]];
            self.imArtist = [ImArtist modelObjectWithDictionary:[dict objectForKey:kEntryImArtist]];
            self.imName = [ImName modelObjectWithDictionary:[dict objectForKey:kEntryImName]];
            self.title = [Title modelObjectWithDictionary:[dict objectForKey:kEntryTitle]];
            self.summary = [Summary modelObjectWithDictionary:[dict objectForKey:kEntrySummary]];
            self.imReleaseDate = [ImReleaseDate modelObjectWithDictionary:[dict objectForKey:kEntryImReleaseDate]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.imContentType dictionaryRepresentation] forKey:kEntryImContentType];
    [mutableDict setValue:[self.rights dictionaryRepresentation] forKey:kEntryRights];
    [mutableDict setValue:[self.category dictionaryRepresentation] forKey:kEntryCategory];
    [mutableDict setValue:[self.entryIdentifier dictionaryRepresentation] forKey:kEntryId];
    NSMutableArray *tempArrayForImImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imImage) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImImage] forKey:kEntryImImage];
    [mutableDict setValue:[self.imPrice dictionaryRepresentation] forKey:kEntryImPrice];
    [mutableDict setValue:[self.link dictionaryRepresentation] forKey:kEntryLink];
    [mutableDict setValue:[self.imArtist dictionaryRepresentation] forKey:kEntryImArtist];
    [mutableDict setValue:[self.imName dictionaryRepresentation] forKey:kEntryImName];
    [mutableDict setValue:[self.title dictionaryRepresentation] forKey:kEntryTitle];
    [mutableDict setValue:[self.summary dictionaryRepresentation] forKey:kEntrySummary];
    [mutableDict setValue:[self.imReleaseDate dictionaryRepresentation] forKey:kEntryImReleaseDate];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.imContentType = [aDecoder decodeObjectForKey:kEntryImContentType];
    self.rights = [aDecoder decodeObjectForKey:kEntryRights];
    self.category = [aDecoder decodeObjectForKey:kEntryCategory];
    self.entryIdentifier = [aDecoder decodeObjectForKey:kEntryId];
    self.imImage = [aDecoder decodeObjectForKey:kEntryImImage];
    self.imPrice = [aDecoder decodeObjectForKey:kEntryImPrice];
    self.link = [aDecoder decodeObjectForKey:kEntryLink];
    self.imArtist = [aDecoder decodeObjectForKey:kEntryImArtist];
    self.imName = [aDecoder decodeObjectForKey:kEntryImName];
    self.title = [aDecoder decodeObjectForKey:kEntryTitle];
    self.summary = [aDecoder decodeObjectForKey:kEntrySummary];
    self.imReleaseDate = [aDecoder decodeObjectForKey:kEntryImReleaseDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imContentType forKey:kEntryImContentType];
    [aCoder encodeObject:_rights forKey:kEntryRights];
    [aCoder encodeObject:_category forKey:kEntryCategory];
    [aCoder encodeObject:_entryIdentifier forKey:kEntryId];
    [aCoder encodeObject:_imImage forKey:kEntryImImage];
    [aCoder encodeObject:_imPrice forKey:kEntryImPrice];
    [aCoder encodeObject:_link forKey:kEntryLink];
    [aCoder encodeObject:_imArtist forKey:kEntryImArtist];
    [aCoder encodeObject:_imName forKey:kEntryImName];
    [aCoder encodeObject:_title forKey:kEntryTitle];
    [aCoder encodeObject:_summary forKey:kEntrySummary];
    [aCoder encodeObject:_imReleaseDate forKey:kEntryImReleaseDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    AppItem *copy = [[AppItem alloc] init];
    
    if (copy) {

        copy.imContentType = [self.imContentType copyWithZone:zone];
        copy.rights = [self.rights copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.entryIdentifier = [self.entryIdentifier copyWithZone:zone];
        copy.imImage = [self.imImage copyWithZone:zone];
        copy.imPrice = [self.imPrice copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.imArtist = [self.imArtist copyWithZone:zone];
        copy.imName = [self.imName copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.summary = [self.summary copyWithZone:zone];
        copy.imReleaseDate = [self.imReleaseDate copyWithZone:zone];
    }
    
    return copy;
}


@end
