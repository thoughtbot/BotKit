//
//  NSCountedSet+ObjectAccess.m
//  BotKit
//
//  Created by theo on 3/8/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "NSCountedSet+ObjectAccess.h"
#import "NSArray+ObjectAccess.h"

@implementation NSCountedSet (ObjectAccess)

#pragma mark - Function Helpers

NSInteger compare(const void *i, const void *j)
{
    return *(NSInteger *)i - *(NSInteger *)j;
}

#pragma mark - Public Methods

- (id)randomObject
{
    NSArray *setArray = [self allObjects];
    return [setArray objectAtIndex:arc4random()%[setArray count]];
}

- (id)randomObjectUsingCountsAsWeights
{
    CGFloat *weights = (CGFloat *)calloc(self.count, sizeof(CGFloat));
    NSArray *objects = [self allObjects];

    for (NSInteger i = 0; i < objects.count; i++)
        weights[i] = (CGFloat)[self countForObject:objects[i]];

    return [objects randomObjectUsingFastWeights:weights];
}

- (id)mostCommonObject
{
    id returnObj = nil;
    NSInteger max = -NSIntegerMax;

    for (id obj in self) {
        NSInteger objCount = [self countForObject:obj];

        if (objCount > max) { max = objCount; returnObj = obj; }
    }
    return returnObj;
}

- (id)leastCommonObject
{
    id returnObj = nil;
    NSInteger min = NSIntegerMax;

    for (id obj in self) {
        NSInteger objCount = [self countForObject:obj];

        if (objCount < min) { min = objCount; returnObj = obj; }
    }
    return returnObj;
}

- (NSArray *)arrayOfMostCommonObjectsWithLimit:(NSInteger)N;
{
    NSInteger size = self.count;

    if (N >= size) return [self allObjects];

    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableArray *counts = [[NSMutableArray alloc] init];
    NSMutableArray *objs = [[NSMutableArray alloc] init];

    NSInteger *countsCArray = (NSInteger*)calloc(size, sizeof(NSInteger));

    NSInteger c = 0;
    for (id obj in self) {
        NSInteger count = [self countForObject:obj];
        [counts addObject:@(count)];
        countsCArray[c] = count;
        [objs addObject:obj];
        c++;
    }

    qsort(countsCArray, size, sizeof(NSInteger), compare);

    for (NSInteger i = size - 1; i >= size - N; i--) {
        NSInteger num = countsCArray[i];
        NSInteger index = (NSInteger)[counts indexOfObject:@(num)];
        [result addObject:objs[index]];
    }

    free(countsCArray);

    return [NSArray arrayWithArray:result];
}

- (NSInteger)countAllObjects
{
    NSInteger total = 0;
    for (id obj in self)
        total += [self countForObject:obj];
    return total;
}

- (NSArray *)flattenedObjects
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id obj in self) {
        NSInteger count = [self countForObject:obj];
        for (NSInteger i = 0; i < count; ++i) {
            [array addObject:obj];
        }
    }
    return [NSArray arrayWithArray:array];
}

@end

