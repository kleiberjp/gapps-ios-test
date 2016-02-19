//
//  AppItem.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AppItem.h"
#import "Entry.h"


NSString *const kAppItemEntry = @"entry";


@interface AppItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AppItem

@synthesize entry = _entry;


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
    NSObject *receivedEntry = [dict objectForKey:kAppItemEntry];
    NSMutableArray *parsedEntry = [NSMutableArray array];
    if ([receivedEntry isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEntry) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEntry addObject:[Entry modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEntry isKindOfClass:[NSDictionary class]]) {
       [parsedEntry addObject:[Entry modelObjectWithDictionary:(NSDictionary *)receivedEntry]];
    }

    self.entry = [NSArray arrayWithArray:parsedEntry];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForEntry = [NSMutableArray array];
    for (NSObject *subArrayObject in self.entry) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEntry addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEntry addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEntry] forKey:kAppItemEntry];

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

    self.entry = [aDecoder decodeObjectForKey:kAppItemEntry];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_entry forKey:kAppItemEntry];
}

- (id)copyWithZone:(NSZone *)zone
{
    AppItem *copy = [[AppItem alloc] init];
    
    if (copy) {

        copy.entry = [self.entry copyWithZone:zone];
    }
    
    return copy;
}


@end
