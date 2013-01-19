//
//  BKFloatMatrix.m
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "BKFloatMatrix.h"

@implementation BKFloatMatrix

@synthesize unrolled = _unrolled;
@synthesize length = _length;
@synthesize dimension = _dimension;
@synthesize rows = _rows;
@synthesize cols = _cols;

- (id)initWithDimension:(BKMatrixDimension)dimension
{
    return [self initWithRows:dimension.rows columns:dimension.cols];
}

- (id)initWithRows:(int)rows
           columns:(int)cols
{
    self = [super init];
    if (self) {
        _rows = rows;
        _cols = cols;
        _dimension = BKMatrixDimensionMake(_rows, _cols);
        _unrolled = (CGFloat*)calloc(_rows * _cols, sizeof(CGFloat));
    }
    return self;
}

- (NSInteger)length
{
    return _rows * _cols;
}

- (CGFloat *)unrolled
{
    return _unrolled;
}

- (BOOL)containsIndex:(NSIndexPath *)index
{
    BOOL rowCheck = (index.row >= 0) && (index.row < _rows);
    BOOL colCheck = (index.section >= 0) && (index.section < _cols);
    
    return rowCheck && colCheck;
}

- (NSInteger)posForIndex:(NSIndexPath *)index
{
    return index.row * _cols + index.section;
}

- (NSIndexPath *)indexForPos:(int)pos
{
    NSInteger i = (pos - pos % _cols) / _cols;
    NSInteger j = pos % _cols;
    return [NSIndexPath indexPathForItem:i inSection:j];
}

- (CGFloat)floatAtIndex:(NSIndexPath *)index
{
    NSInteger pos = [self posForIndex:index];
    return _unrolled[pos];
}

- (CGFloat)floatAtRow:(NSInteger)row
             column:(NSInteger)col
{
    return _unrolled[row * _cols + col];
}

- (void)replaceFloatAtRow:(NSInteger)row
                column:(NSInteger)col
                withFloat:(CGFloat)aFloat
{
    _unrolled[row * _cols + col] = aFloat;
}

- (void)replaceFloatAtIndex:(NSIndexPath *)index
                  withFloat:(CGFloat)aFloat
{
    _unrolled[[self posForIndex:index]] = aFloat;
}

- (void)randomizeValuesWithEpsilon:(CGFloat)epsilon
{
    for (NSInteger i=0; i<_rows * _cols; ++i)
        _unrolled[i] = arc4random() * (2 * epsilon) - epsilon;
}

- (void)mapIndicesToBlock:(void (^)(NSIndexPath *))block
{
    for (NSInteger i=0; i<_rows * _cols; ++i)
        block([self indexForPos:i]);
}

- (CGFloat)sumOfElementsInRow:(NSInteger)rowIndex
{
    CGFloat sum = 0.0;
    for (int i=0; i<_cols; ++i)
        sum += [self floatAtRow:rowIndex column:i];
    
    return sum;
}

- (CGFloat)sumOfElementsInColumn:(NSInteger)colIndex
{
    CGFloat sum = 0.0;
    for (int i=0; i<_rows; ++i)
        sum += [self floatAtRow:i column:colIndex];
    
    return sum;
}

- (NSInteger)columnIndexForSmallestElementInRow:(NSInteger)rowIndex
{
    CGFloat min = CGFLOAT_MAX;
    NSInteger index = 0;
    
    for (int i=0; i<_cols; ++i) {
        CGFloat value = [self floatAtRow:rowIndex column:i];
        
        if (value < min) { min = value; index = i; }
    }
    
    return index;
}

- (NSInteger)rowIndexForSmallestElementInColumn:(NSInteger)colIndex
{
    CGFloat min = CGFLOAT_MAX;
    NSInteger index = 0;
    
    for (int i=0; i<_rows; ++i) {
        CGFloat value = [self floatAtRow:i column:colIndex];
        
        if (value < min) { min = value; index = i; }
    }
    
    return index;
}

- (NSInteger)columnIndexForLargestElementInRow:(NSInteger)rowIndex
{
    CGFloat max = CGFLOAT_MIN;
    NSInteger index = 0;
    
    for (int i=0; i<_cols; ++i) {
        CGFloat value = [self floatAtRow:rowIndex column:i];
        
        if (value > max) { max = value; index = i; }
    }
    
    return index;
}

- (NSInteger)rowIndexForLargestElementInColumn:(NSInteger)colIndex
{
    CGFloat max = CGFLOAT_MIN;
    NSInteger index = 0;
    
    for (int i=0; i<_rows; ++i) {
        CGFloat value = [self floatAtRow:i column:colIndex];
        
        if (value > max) { max = value; index = i; }
    }
    
    return index;
}

- (NSIndexPath *)indexOfSmallestElement
{
    __block CGFloat min = CGFLOAT_MAX;
    __block NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    
    [self mapIndicesToBlock:^(NSIndexPath *path) {
        CGFloat value = [self floatAtIndex:path];
        
        if (value < min) { min = value; index = path; }
    }];
    
    return index;
}

- (NSIndexPath *)indexOfLargestElement
{
    __block CGFloat max = CGFLOAT_MIN;
    __block NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    
    [self mapIndicesToBlock:^(NSIndexPath *path) {
        CGFloat value = [self floatAtIndex:path];
        
        if (value > max) { max = value; index = path; }
    }];
    
    return index;
}

- (void)print
{
    printf("\n");
    for (int i = 0; i < _rows; ++i) {
        for (int j = 0; j < _cols; ++j) {
            printf(" %05.2f ", [self floatAtRow:i column:j]);
        }
        printf("\n");
    }
    printf("\n");
}

@end