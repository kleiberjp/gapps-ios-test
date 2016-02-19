//
//  ImContentType.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImContentType.h"
#import "Attributes.h"


NSString *const kImContentTypeAttributes = @"attributes";


@interface ImContentType ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImContentType

@synthesize attributes = _attributes;


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
            self.attributes = [Attributes modelObjectWithDictionary:[dict objectForKey:kImContentTypeAttributes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.attributes dictionaryRepresentation] forKey:kImContentTypeAttributes];

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

    self.attributes = [aDecoder decodeObjectForKey:kImContentTypeAttributes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_attributes forKey:kImContentTypeAttributes];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImContentType *copy = [[ImContentType alloc] init];
    
    if (copy) {

        copy.attributes = [self.attributes copyWithZone:zone];
    }
    
    return copy;
}


@end
