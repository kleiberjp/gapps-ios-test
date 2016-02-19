//
//  Attributes.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Attributes.h"


NSString *const kAttributesAmount = @"amount";
NSString *const kAttributesHeight = @"height";
NSString *const kAttributesScheme = @"scheme";
NSString *const kAttributesRel = @"rel";
NSString *const kAttributesHref = @"href";
NSString *const kAttributesImBundleId = @"im:bundleId";
NSString *const kAttributesLabel = @"label";
NSString *const kAttributesImId = @"im:id";
NSString *const kAttributesCurrency = @"currency";
NSString *const kAttributesType = @"type";
NSString *const kAttributesTerm = @"term";


@interface Attributes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Attributes

@synthesize amount = _amount;
@synthesize height = _height;
@synthesize scheme = _scheme;
@synthesize rel = _rel;
@synthesize href = _href;
@synthesize imBundleId = _imBundleId;
@synthesize label = _label;
@synthesize imId = _imId;
@synthesize currency = _currency;
@synthesize type = _type;
@synthesize term = _term;


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
            self.amount = [self objectOrNilForKey:kAttributesAmount fromDictionary:dict];
            self.height = [self objectOrNilForKey:kAttributesHeight fromDictionary:dict];
            self.scheme = [self objectOrNilForKey:kAttributesScheme fromDictionary:dict];
            self.rel = [self objectOrNilForKey:kAttributesRel fromDictionary:dict];
            self.href = [self objectOrNilForKey:kAttributesHref fromDictionary:dict];
            self.imBundleId = [self objectOrNilForKey:kAttributesImBundleId fromDictionary:dict];
            self.label = [self objectOrNilForKey:kAttributesLabel fromDictionary:dict];
            self.imId = [self objectOrNilForKey:kAttributesImId fromDictionary:dict];
            self.currency = [self objectOrNilForKey:kAttributesCurrency fromDictionary:dict];
            self.type = [self objectOrNilForKey:kAttributesType fromDictionary:dict];
            self.term = [self objectOrNilForKey:kAttributesTerm fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.amount forKey:kAttributesAmount];
    [mutableDict setValue:self.height forKey:kAttributesHeight];
    [mutableDict setValue:self.scheme forKey:kAttributesScheme];
    [mutableDict setValue:self.rel forKey:kAttributesRel];
    [mutableDict setValue:self.href forKey:kAttributesHref];
    [mutableDict setValue:self.imBundleId forKey:kAttributesImBundleId];
    [mutableDict setValue:self.label forKey:kAttributesLabel];
    [mutableDict setValue:self.imId forKey:kAttributesImId];
    [mutableDict setValue:self.currency forKey:kAttributesCurrency];
    [mutableDict setValue:self.type forKey:kAttributesType];
    [mutableDict setValue:self.term forKey:kAttributesTerm];

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

    self.amount = [aDecoder decodeObjectForKey:kAttributesAmount];
    self.height = [aDecoder decodeObjectForKey:kAttributesHeight];
    self.scheme = [aDecoder decodeObjectForKey:kAttributesScheme];
    self.rel = [aDecoder decodeObjectForKey:kAttributesRel];
    self.href = [aDecoder decodeObjectForKey:kAttributesHref];
    self.imBundleId = [aDecoder decodeObjectForKey:kAttributesImBundleId];
    self.label = [aDecoder decodeObjectForKey:kAttributesLabel];
    self.imId = [aDecoder decodeObjectForKey:kAttributesImId];
    self.currency = [aDecoder decodeObjectForKey:kAttributesCurrency];
    self.type = [aDecoder decodeObjectForKey:kAttributesType];
    self.term = [aDecoder decodeObjectForKey:kAttributesTerm];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_amount forKey:kAttributesAmount];
    [aCoder encodeObject:_height forKey:kAttributesHeight];
    [aCoder encodeObject:_scheme forKey:kAttributesScheme];
    [aCoder encodeObject:_rel forKey:kAttributesRel];
    [aCoder encodeObject:_href forKey:kAttributesHref];
    [aCoder encodeObject:_imBundleId forKey:kAttributesImBundleId];
    [aCoder encodeObject:_label forKey:kAttributesLabel];
    [aCoder encodeObject:_imId forKey:kAttributesImId];
    [aCoder encodeObject:_currency forKey:kAttributesCurrency];
    [aCoder encodeObject:_type forKey:kAttributesType];
    [aCoder encodeObject:_term forKey:kAttributesTerm];
}

- (id)copyWithZone:(NSZone *)zone
{
    Attributes *copy = [[Attributes alloc] init];
    
    if (copy) {

        copy.amount = [self.amount copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.scheme = [self.scheme copyWithZone:zone];
        copy.rel = [self.rel copyWithZone:zone];
        copy.href = [self.href copyWithZone:zone];
        copy.imBundleId = [self.imBundleId copyWithZone:zone];
        copy.label = [self.label copyWithZone:zone];
        copy.imId = [self.imId copyWithZone:zone];
        copy.currency = [self.currency copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.term = [self.term copyWithZone:zone];
    }
    
    return copy;
}


@end
