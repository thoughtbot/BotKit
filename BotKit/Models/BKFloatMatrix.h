//
//  BKFloatMatrix.h
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "BKMathStructs.h"

@interface BKFloatMatrix : NSObject

- (id)initWithRows:(NSInteger)rows columns:(NSInteger)cols;
- (id)initWithDimension:(BKMatrixDimension)dimension;

@property (nonatomic) NSInteger rows;
@property (nonatomic) NSInteger cols;
@property (nonatomic, readonly) BKMatrixDimension dimension;
@property (nonatomic, readonly) CGFloat *unrolled;
@property (nonatomic, readonly) NSInteger length;

- (CGFloat)floatAtRow:(NSInteger)row
             column:(NSInteger)col;

- (CGFloat)floatAtIndex:(NSIndexPath *)index;

- (void)replaceFloatAtIndex:(NSIndexPath *)index
                  withFloat:(CGFloat)aFloat;

- (void)replaceFloatAtRow:(NSInteger)row
                   column:(NSInteger)col
                withFloat:(CGFloat)aFloat;

- (BOOL)containsIndex:(NSIndexPath *)index;

- (void)randomizeValuesWithEpsilon:(CGFloat)epsilon;

- (void)mapIndicesToBlock:(void (^)(NSIndexPath *))block;

- (CGFloat)sumOfElementsInRow:(NSInteger)rowIndex;
- (CGFloat)sumOfElementsInColumn:(NSInteger)colIndex;

- (NSInteger)columnIndexForSmallestElementInRow:(NSInteger)rowIndex;
- (NSInteger)rowIndexForSmallestElementInColumn:(NSInteger)colIndex;

- (NSInteger)columnIndexForLargestElementInRow:(NSInteger)rowIndex;
- (NSInteger)rowIndexForLargestElementInColumn:(NSInteger)colIndex;

- (NSIndexPath *)indexOfSmallestElement;
- (NSIndexPath *)indexOfLargestElement;

- (void)print;

@end
