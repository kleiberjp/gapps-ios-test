//
//  ImPrice.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImPrice.h"
#import "Attributes.h"


NSString *const kImPriceLabel = @"label";
NSString *const kImPriceAttributes = @"attributes";


@interface ImPrice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImPrice

@synthesize label = _label;
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
            self.label = [self objectOrNilForKey:kImPriceLabel fromDictionary:dict];
            self.attributes = [Attributes modelObjectWithDictionary:[dict objectForKey:kImPriceAttributes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.label forKey:kImPriceLabel];
    [mutableDict setValue:[self.attributes dictionaryRepresentation] forKey:kImPriceAttributes];

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

    self.label = [aDecoder decodeObjectForKey:kImPriceLabel];
    self.attributes = [aDecoder decodeObjectForKey:kImPriceAttributes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_label forKey:kImPriceLabel];
    [aCoder encodeObject:_attributes forKey:kImPriceAttributes];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImPrice *copy = [[ImPrice alloc] init];
    
    if (copy) {

        copy.label = [self.label copyWithZone:zone];
        copy.attributes = [self.attributes copyWithZone:zone];
    }
    
    return copy;
}


@end
