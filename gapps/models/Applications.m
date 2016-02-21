//
//  Applications.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Applications.h"

NSString *const kApplicationsEntry = @"entry";


@interface Applications ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Applications


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
    NSObject *receivedEntry = [dict objectForKey:kApplicationsEntry];
    NSMutableArray *parsedEntry = [NSMutableArray array];
    if ([receivedEntry isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEntry) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEntry addObject:[AppItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEntry isKindOfClass:[NSDictionary class]]) {
       [parsedEntry addObject:[AppItem modelObjectWithDictionary:(NSDictionary *)receivedEntry]];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEntry] forKey:kApplicationsEntry];

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

    self.entry = [aDecoder decodeObjectForKey:kApplicationsEntry];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_entry forKey:kApplicationsEntry];
}

- (id)copyWithZone:(NSZone *)zone
{
    Applications *copy = [[Applications alloc] init];
    
    if (copy) {

        copy.entry = [self.entry copyWithZone:zone];
    }
    
    return copy;
}


@end
