//
//  Category.m
//
//  Created by Kleiber Perez on 18/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CategoryItem.h"
#import "Attributes.h"


NSString *const kCategoryAttributes = @"attributes";


@interface CategoryItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoryItem

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
            self.attributes = [Attributes modelObjectWithDictionary:[dict objectForKey:kCategoryAttributes]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.attributes dictionaryRepresentation] forKey:kCategoryAttributes];

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

    self.attributes = [aDecoder decodeObjectForKey:kCategoryAttributes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_attributes forKey:kCategoryAttributes];
}

- (id)copyWithZone:(NSZone *)zone
{
    CategoryItem *copy = [[CategoryItem alloc] init];
    
    if (copy) {

        copy.attributes = [self.attributes copyWithZone:zone];
    }
    
    return copy;
}


@end
