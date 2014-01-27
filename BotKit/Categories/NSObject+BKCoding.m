//
//  NSObject+WRCoding.m
//  Weather
//
//  Created by Mark Adams on 7/7/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

#import "NSObject+BKCoding.h"

@implementation NSObject (BKCoding)

- (id)initWithDictionary:(NSDictionary *)dictionary;
{
    self = [self init];

    if (!self) return nil;
    
    [self setValuesForKeysWithDictionary:dictionary];
    
    return self;
}

- (NSArray *)arrayForKey:(NSString *)key;
{
    return [self valueForKey:key assertingClass:[NSArray class]];
}

- (NSArray *)arrayOfClass:(Class)objectClass forKey:(NSString *)key;
{
    NSAssert1([objectClass respondsToSelector:@selector(initWithDictionary:)], @"%@ does not respond to initWithDictionary:", NSStringFromClass(objectClass));
    
    NSArray *dictionaries = [self arrayOfDictionariesForKey:key];
    
    if (!dictionaries || ![dictionaries isKindOfClass:[NSArray class]] || !dictionaries.count)
        return nil;
    
    id newObject = nil;
    NSMutableArray *newObjects = [NSMutableArray array];
    
    for (NSDictionary *dictionary in dictionaries)
    {
        newObject = [[objectClass alloc] initWithDictionary:dictionary];
        
        if (!newObject) continue;

        [newObjects addObject:newObject];
    }
    
    if (!newObjects.count)
        return nil;
    
    return newObjects;
}

- (NSArray *)arrayOfClass:(Class)objectClass;
{
	NSAssert1([objectClass respondsToSelector:@selector(initWithDictionary:)], @"%@ does not respond to initWithDictionary:", NSStringFromClass(objectClass));
    
    if (![self isKindOfClass:[NSArray class]] || ![(NSArray *)self count])
        return nil;
    
	id newObject = nil;
    NSMutableArray *newObjects = [NSMutableArray array];
    
    for (NSDictionary *dictionary in (NSArray *)self)
    {
        newObject = [[objectClass alloc] initWithDictionary:dictionary];
        
        if (!newObject) continue;
        
        [newObjects addObject:newObject];
    }
    
    if (!newObjects.count)
        return nil;
    
    return newObjects;
}

- (NSArray *)arrayOfDictionariesForKey:(NSString *)key;
{
    NSArray *possibleDictionaries = [self valueForKey:key assertingClass:[NSArray class]];
    
    if (![self contentsOfCollection:possibleDictionaries areKindOfClass:[NSDictionary class]])
    {
        NSAssert(NO, @"Collection does not contain only dictionaries");
        return nil;
    }

    return possibleDictionaries;
}

- (NSArray *)arrayOfStringsForKey:(NSString *)key;
{
    NSArray *possibleStrings = [self valueForKey:key assertingClass:[NSArray class]];
    
    if (![self contentsOfCollection:possibleStrings areKindOfClass:[NSString class]])
    {
        NSAssert(NO, @"Collection does not contain only strings");
        return nil;
    }

    return possibleStrings;
}

- (BOOL)boolForKey:(NSString *)key;
{
    return [[self valueForKey:key assertingRespondsToSelector:@selector(boolValue)] boolValue];
}

- (NSData *)dataForKey:(NSString *)key;
{
    return [self valueForKey:key assertingClass:[NSData class]];
}

- (NSDate *)dateForKey:(NSString *)key;
{
    id value = [self valueForKey:key];
    
    if (!value || value == (id)[NSNull null])
        return nil;
    
    if ([value isKindOfClass:[NSDate class]])
        return value;
    
    if ([value isKindOfClass:[NSString class]])
        return [[[NSDateFormatter alloc] init] dateFromString:value];
    
    if ([value isKindOfClass:[NSNumber class]])
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue] / 1000];
        
    NSAssert1(NO, @"Couldn't make an NSDate from %@", NSStringFromClass([value class]));
    
    return nil;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key;
{
    return [self valueForKey:key assertingClass:[NSDictionary class]];
}

- (double)doubleForKey:(NSString *)key;
{
    return [[self valueForKey:key assertingRespondsToSelector:@selector(doubleValue)] doubleValue];
}

- (CGFloat)floatForKey:(NSString *)key;
{
    return [[self valueForKey:key assertingRespondsToSelector:@selector(floatValue)] floatValue];
}

- (NSInteger)integerForKey:(NSString *)key;
{
    return [[self valueForKey:key assertingRespondsToSelector:@selector(integerValue)] integerValue];
}

- (NSString *)stringForKey:(NSString *)key;
{
    return [self valueForKey:key assertingClass:[NSString class]];
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)key;
{
    return [[self valueForKey:key assertingRespondsToSelector:@selector(unsignedIntegerValue)] unsignedIntegerValue];
}

- (NSURL *)URLForKey:(NSString *)key;
{
	id stringValue = [self valueForKey:key assertingClass:[NSString class]];

    if (!stringValue)
        return nil;
    
    return [NSURL URLWithString:stringValue];
}

- (id)valueForKey:(NSString *)key assertingClass:(Class)class;
{
    id value = [self valueForKey:key];
    
    if (!value || value == [NSNull null])
        return nil;
    
    if (![value isKindOfClass:class])
    {
        NSAssert2(NO, @"Method expects an object of class %@, but class of return value is %@", NSStringFromClass(class), NSStringFromClass([value class]));
        return nil;
    }
    
    return value;
}

- (id)valueForKey:(NSString *)key assertingRespondsToSelector:(SEL)selector;
{
    id value = [self valueForKey:key];
    
    if (!value || value == [NSNull null])
        return nil;

    if (![value respondsToSelector:selector])
    {
        NSAssert2(NO, @"Object of class: %@ does not respond to selector: %@", NSStringFromClass([value class]), NSStringFromSelector(selector));
        return nil;
    }
    
    return value;
}

- (BOOL)contentsOfCollection:(id <NSFastEnumeration>)theCollection areKindOfClass:(Class)theClass;
{
    BOOL areKindOfClass = YES;
    
    for (id theObject in theCollection)
        if (![theObject isKindOfClass:theClass])
            return areKindOfClass = NO;
    
    return areKindOfClass;
}

@end
