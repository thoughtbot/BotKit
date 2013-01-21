//
//  BKObjectMatrix.m
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "BKObjectMatrix.h"

NSString *pathDir(NSString *path)
{
    if ([path pathExtension] != nil) {
        NSMutableArray *pathComps = [[NSMutableArray alloc] initWithArray:[path pathComponents]];
        [pathComps removeLastObject];
        return [NSString pathWithComponents:pathComps];
    }
    return path;
}

@implementation BKObjectMatrix

- (id)initWithDimension:(BKMatrixDimension)dimension
{
    return [self initWithRows:dimension.rows columns:dimension.cols];
}

- (id)initWithArray:(NSArray *)array
            andRows:(NSInteger)r
{
    self = [super init];
    
    if (self) {
        _unrolled = [[NSMutableArray alloc] initWithArray:array];
        _rows = r;
        _cols = [array count]/r;
    }
    return self;
}

- (id)initWithRows:(NSInteger)rows columns:(NSInteger)columns
{
    self = [super init];
    
    if (self) {
        _unrolled = [[NSMutableArray alloc] init];
        _rows = rows;
        _cols = columns;
        for (NSInteger i = 0; i < _rows * _cols; ++ i) [_unrolled addObject:[NSNull null]];
    }
    return self;
}

- (id)initWithFile:(NSString *)path
      rowDelimiter:(NSString *)rowDel
      colDelimiter:(NSString *)colDel
        parseBlock:(id (^)(NSString *))parser
{
    self = [super init];
    
    if (self) {
        _unrolled = [[NSMutableArray alloc] init];
        
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        
        if (!content && error)
        {
            NSLog(@"Error reading: %@", [error localizedDescription]);
        }
        else
        {
            NSArray *rowsArr = [content componentsSeparatedByString:colDel];
            _rows = [rowsArr count];
            _cols = [[[rowsArr objectAtIndex:0] componentsSeparatedByString:rowDel] count];
            
            for (NSString *row in rowsArr)
                for (NSString *cell in [row componentsSeparatedByString:rowDel])
                    [_unrolled addObject:parser(cell)];
        }
    }
    return self;
}

- (BOOL)saveToFile:(NSString *)path
      rowDelimiter:(NSString *)rowDel
      colDelimiter:(NSString *)colDel
        coderBlock:(NSString *(^)(id))coder
{
    NSMutableString *s = [[NSMutableString alloc] init];
    
    for (NSInteger i = 0; i < self.rows; i++) {
        for (NSInteger j = 0; j < self.cols; j++) {
            
            id obj = [self objectAtRow:i column:j];
            [s appendString:coder(obj)];
            
            if (j != self.cols - 1)
                [s appendString:rowDel];
        }
        
        if (i != self.rows-1)
            [s appendString:colDel];
    }
    
    NSError *error = nil;
    NSString *folder = pathDir(path);
    if (![[NSFileManager defaultManager] fileExistsAtPath:folder])
    {
        BOOL madeDir = [[NSFileManager defaultManager] createDirectoryAtPath:folder
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&error];
        if (!madeDir)
            NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    
    error = nil;
    BOOL successful = [s writeToFile:path
                          atomically:YES
                            encoding:NSUTF8StringEncoding
                               error:&error];
    
    if (!successful)
        NSLog(@"Error saving: %@", [error localizedDescription]);
    
    return successful;
}

- (BOOL)containsIndex:(NSIndexPath *)index
{
    BOOL rowCheck = (index.row >= 0) && (index.row < self.rows);
    BOOL colCheck = (index.section >= 0) && (index.section < self.cols);
    
    return rowCheck && colCheck;
}

- (NSInteger)posForIndex:(NSIndexPath *)index
{
    return index.row * self.cols + index.section;
}

- (NSIndexPath *)indexForPos:(NSInteger)pos
{
    NSInteger i = (pos - pos % self.cols) / self.cols;
    NSInteger j = pos % self.cols;
    return [NSIndexPath indexPathForItem:i inSection:j];
}

- (id)objectAtIndex:(NSIndexPath *)index
{
    if (![self containsIndex:index]) return nil;
    
    NSInteger pos = [self posForIndex:index];
    return self.unrolled[pos];
}

- (id)objectAtRow:(NSInteger)row column:(NSInteger)col
{
    NSIndexPath *p = [NSIndexPath indexPathForItem:row inSection:col];
    return [self objectAtIndex:p];
}

- (void)replaceObjectAtIndex:(NSIndexPath *)index withObject:(id)anObject
{
    if (![self containsIndex:index]) return;
    _unrolled[[self posForIndex:index]] = anObject;
}

- (void)mapIndicesToBlock:(void (^)(NSIndexPath *))block
{
    for (NSInteger i = 0; i < self.length; ++i)
        block([self indexForPos:i]);
}

- (NSInteger)length
{
    return self.rows * self.cols;
}

@end
