//
//  ImReleaseDate.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImReleaseDate.h"
#import "Attributes.h"


NSString *const kImReleaseDateLabel = @"label";
NSString *const kImReleaseDateAttributes = @"attributes";


@interface ImReleaseDate ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImReleaseDate

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
            self.label = [self objectOrNilForKey:kImReleaseDateLabel fromDictionary:dict];
            self.attributes = [Attributes modelObjectWithDictionary:[dict objectForKey:kImReleaseDateAttributes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.label forKey:kImReleaseDateLabel];
    [mutableDict setValue:[self.attributes dictionaryRepresentation] forKey:kImReleaseDateAttributes];

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

    self.label = [aDecoder decodeObjectForKey:kImReleaseDateLabel];
    self.attributes = [aDecoder decodeObjectForKey:kImReleaseDateAttributes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_label forKey:kImReleaseDateLabel];
    [aCoder encodeObject:_attributes forKey:kImReleaseDateAttributes];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImReleaseDate *copy = [[ImReleaseDate alloc] init];
    
    if (copy) {

        copy.label = [self.label copyWithZone:zone];
        copy.attributes = [self.attributes copyWithZone:zone];
    }
    
    return copy;
}


@end
