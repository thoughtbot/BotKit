//
//  NSObject+WRCoding.m
//  Weather
//
//  Created by Mark Adams on 7/7/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

#import "NSObject+Coding.h"

@implementation NSObject (Coding)

- (id)initWithDictionary:(NSDictionary *)dictionary;
{
    if (!(self = [self init])) return nil;
    
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
    
    NSArray *keyedObjects = [self arrayOfDictionariesForKey:key];
    if (!keyedObjects || ![keyedObjects isKindOfClass:[NSArray class]] || !keyedObjects.count)
        return nil;
    
    id newObject = nil;
    NSMutableArray *newObjects = [NSMutableArray array];
    for (NSDictionary *keyedObject in keyedObjects)
        if ((newObject = [[objectClass alloc] initWithDictionary:keyedObject]))
            [newObjects addObject:newObject];
    
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
    for (NSDictionary *keyedObject in (NSArray *)self)
        if ((newObject = [[objectClass alloc] initWithDictionary:keyedObject]))
            [newObjects addObject:newObject];
    
    if (!newObjects.count)
        return nil;
    
    return newObjects;
}

- (NSArray *)arrayOfDictionariesForKey:(NSString *)key;
{
    NSArray *allegedDictionaries = [self valueForKey:key assertingClass:[NSArray class]];
    if ([self contentsOfCollection:allegedDictionaries areKindOfClass:[NSDictionary class]])
        return allegedDictionaries;
    
    NSAssert(NO, @"Collection does not contain only dictionaries");
    return nil;
}

- (NSArray *)arrayOfStringsForKey:(NSString *)key;
{
    NSArray *allegedStrings = [self valueForKey:key assertingClass:[NSArray class]];
    if ([self contentsOfCollection:allegedStrings areKindOfClass:[NSString class]])
        return allegedStrings;
    
    NSAssert(NO, @"Collection does not contain only strings");
    return nil;
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
    if (!value || value == (id)[NSNull null]) return nil;
    if ([value isKindOfClass:[NSDate class]]) return value;
    
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
    return stringValue ? [NSURL URLWithString:stringValue] : nil;
}

- (id)valueForKey:(NSString *)key assertingClass:(Class)theClass;
{
    id value = [self valueForKey:key];
    if (!value || value == [NSNull null]) return nil;
    NSAssert2([value isKindOfClass:theClass], @"Method expects an object of class %@, but class of return value is %@", NSStringFromClass(theClass), NSStringFromClass([value class]));
    return [value isKindOfClass:theClass] ? value : nil;
}

- (id)valueForKey:(NSString *)key assertingRespondsToSelector:(SEL)theSelector;
{
    id value = [self valueForKey:key];
    if (!value || value == [NSNull null]) return nil;
    NSAssert2([value respondsToSelector:theSelector], @"Object of class %@ does not respond to selector %@", NSStringFromClass([value class]), NSStringFromSelector(theSelector));
    return [value respondsToSelector:theSelector] ? value : nil;
}

- (BOOL)contentsOfCollection:(id <NSFastEnumeration>)theCollection areKindOfClass:(Class)theClass;
{
    for (id theObject in theCollection) if (![theObject isKindOfClass:theClass]) return NO;
    return YES;    
}

@end
