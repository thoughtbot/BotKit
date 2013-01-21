//
//  BKObjectTensor.m
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "BKObjectTensor.h"

@implementation BKObjectTensor
{
    NSMutableArray *_array;
    NSUInteger *_factors;
    NSUInteger *_dimensionArray;
    NSInteger _depth;
}

@synthesize dimensions = _dimensions;

- (id)initWithDimentions:(NSIndexPath *)dimensions
{
    self = [super init];
    if (self) {
        _depth = [dimensions length];
        
        NSUInteger *tempDimentions = (NSUInteger *)calloc(_depth, sizeof(NSUInteger));
        for (NSInteger i = _depth - 1, j = 0; i >= 0; --i, ++j)
            tempDimentions[i] = [dimensions indexAtPosition:j];
        
        _dimensions = [NSIndexPath indexPathWithIndexes:tempDimentions length:_depth];
        free(tempDimentions);
        
        _array = [[NSMutableArray alloc] init];
        NSInteger size = 1;
        for (NSInteger i = 0; i < _depth; ++i)
            size *= [_dimensions indexAtPosition:i];
        
        for (NSInteger i = 0; i < size; ++i)
            [_array addObject:[NSNull null]];
        
        [self initializeFactors];
    }
    return self;
}

- (id)initWithArray:(NSArray *)array dimensions:(NSIndexPath *)dimensions
{
    self = [super init];
    if (self) {
        _dimensions = dimensions;
        _depth = [_dimensions length];
        _array = [[NSMutableArray alloc] initWithArray:array];
        [self initializeFactors];
    }
    return self;
}

- (void)initializeFactors
{
    free(_factors);
    free(_dimensionArray);
    
    _dimensionArray = (NSUInteger *)calloc(_depth, sizeof(NSUInteger));
    [_dimensions getIndexes:_dimensionArray];
    
    _factors = (NSUInteger *)calloc(_depth, sizeof(NSUInteger));
    _factors[_depth-1] = 1;
    
    for (NSInteger i = _depth-2, j = 0; i >= 0; --i, ++j)
        _factors[i] = _factors[i+1] * _dimensionArray[j];
}

- (NSInteger)posForIndex:(NSIndexPath *)index
{
    NSUInteger *indices = (NSUInteger *)calloc(_depth, sizeof(NSUInteger));
    [index getIndexes:indices];
    
    NSInteger pos = 0;
    for (NSInteger i = 0; i < _depth; ++i)
        pos += _factors[i] * (NSInteger)indices[i];
    
    free(indices);
    return pos;
}

- (NSIndexPath *)indexPathForPosition:(NSInteger)pos
{
    NSUInteger *path = (NSUInteger*)calloc(_depth, sizeof(NSUInteger));
    NSInteger *mods = (NSInteger*)calloc(_depth, sizeof(NSInteger));
    
    mods[0] = pos % _factors[0];
    path[0] = (pos - mods[0]) / (CGFloat)_factors[0];
    for (NSInteger i = 1; i < _depth; ++i) {
        mods[i] = mods[i-1] % _factors[i];
        path[i] = (mods[i-1] - mods[i]) / (CGFloat)_factors[i];
    }
    
    NSIndexPath *index = [NSIndexPath indexPathWithIndexes:path length:_depth];
    free(path);
    free(mods);
    
    return index;
}

- (id)objectAtIndex:(NSIndexPath *)index
{
    NSInteger pos = [self posForIndex:index];
    return _array[pos];
}

- (void)replaceObjectAtIndex:(NSIndexPath *)index
                  withObject:(id)anObject
{
    NSInteger pos = [self posForIndex:index];
    _array[pos] = anObject;
}

- (BOOL)containsIndex:(NSIndexPath *)index
{
    if ([index length] != _depth) return NO;
    
    NSUInteger *indices = (NSUInteger *)calloc(_depth, sizeof(NSUInteger));
    [index getIndexes:indices];
    
    BOOL isContained = YES;
    for (NSInteger i = 0; i < _depth; ++i) {
        
        if (_dimensionArray[i] < indices[i]) { isContained = NO; break; }
    }
    
    free(indices);
    return isContained;
}

- (void)mapIndicesToBlock:(BKObjectTensorMapIndexPathBlock)block
{
    for (NSInteger i = 0; i < _array.count; ++i)
        block([self indexPathForPosition:i]);
}

- (void)dealloc
{
    free(_factors);
    free(_dimensionArray);
}

@end