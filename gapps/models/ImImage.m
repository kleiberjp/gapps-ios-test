//
//  ImImage.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImImage.h"
#import "Attributes.h"


NSString *const kImImageLabel = @"label";
NSString *const kImImageAttributes = @"attributes";


@interface ImImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImImage


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
            self.label = [self objectOrNilForKey:kImImageLabel fromDictionary:dict];
            self.attributes = [Attributes modelObjectWithDictionary:[dict objectForKey:kImImageAttributes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.label forKey:kImImageLabel];
    [mutableDict setValue:[self.attributes dictionaryRepresentation] forKey:kImImageAttributes];

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

    self.label = [aDecoder decodeObjectForKey:kImImageLabel];
    self.attributes = [aDecoder decodeObjectForKey:kImImageAttributes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_label forKey:kImImageLabel];
    [aCoder encodeObject:_attributes forKey:kImImageAttributes];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImImage *copy = [[ImImage alloc] init];
    
    if (copy) {

        copy.label = [self.label copyWithZone:zone];
        copy.attributes = [self.attributes copyWithZone:zone];
    }
    
    return copy;
}


@end
