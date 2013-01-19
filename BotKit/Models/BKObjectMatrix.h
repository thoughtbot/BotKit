//
//  BKObjectMatrix.h
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "BKMathStructs.h"

@interface BKObjectMatrix : NSObject

- (id)initWithDimension:(BKMatrixDimension)dimension;
- (id)initWithArray:(NSArray *)array andRows:(NSInteger)rows;
- (id)initWithRows:(NSInteger)rows columns:(NSInteger)columns;

- (id)initWithFile:(NSString *)path
      rowDelimiter:(NSString *)rowDel
      colDelimiter:(NSString *)colDel
        parseBlock:(id (^)(NSString *cell))parser;

@property (nonatomic) NSInteger rows;
@property (nonatomic) NSInteger cols;

- (BOOL)saveToFile:(NSString *)path
      rowDelimiter:(NSString *)rowDel
      colDelimiter:(NSString *)colDel
        coderBlock:(NSString *(^)(id))coder;

- (id)objectAtRow:(NSInteger)row column:(NSInteger)col;
- (id)objectAtIndex:(NSIndexPath *)index;

- (void)replaceObjectAtIndex:(NSIndexPath *)index withObject:(id)anObject;

- (BOOL)containsIndex:(NSIndexPath *)index;

- (void)mapIndicesToBlock:(void (^)(NSIndexPath *))block;

- (NSMutableArray *)matrix;

@end
