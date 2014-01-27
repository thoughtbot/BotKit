//
//  NSObject+WRCoding.h
//  Weather
//
//  Created by Mark Adams on 7/7/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

@interface NSObject (BKCoding)

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSArray *)arrayOfClass:(Class)objectClass forKey:(NSString *)key;
- (NSArray *)arrayOfClass:(Class)objectClass;
- (NSArray *)arrayOfDictionariesForKey:(NSString *)key;
- (NSArray *)arrayOfStringsForKey:(NSString *)key;

- (BOOL)boolForKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSUInteger)unsignedIntegerForKey:(NSString *)key;
- (NSURL *)URLForKey:(NSString *)key;

- (id)valueForKey:(NSString *)key assertingClass:(Class)class;
- (id)valueForKey:(NSString *)key assertingRespondsToSelector:(SEL)selector;
- (BOOL)contentsOfCollection:(id <NSFastEnumeration>)theCollection areKindOfClass:(Class)class;

@end
