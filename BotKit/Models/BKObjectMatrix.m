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
{
    NSMutableArray *_matrix;
}

@synthesize rows = _rows;
@synthesize cols = _cols;

- (id)initWithDimension:(BKMatrixDimension)dimension
{
    return [self initWithRows:dimension.rows columns:dimension.cols];
}

- (id)initWithArray:(NSArray *)array
            andRows:(NSInteger)r
{
    self = [super init];
    if (self) {
        _matrix = [[NSMutableArray alloc] initWithArray:array];
        _rows = r;
        _cols = [array count]/r;
    }
    return self;
}

- (id)initWithRows:(NSInteger)rows columns:(NSInteger)columns
{
    self = [super init];
    if (self) {
        _matrix = [[NSMutableArray alloc] init];
        for (int i=0; i<_rows*_cols; ++ i) [_matrix addObject:[NSNull null]];
        _rows = rows;
        _cols = columns;
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
        _matrix = [[NSMutableArray alloc] init];
        
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
        if (!content && error) {
            NSLog(@"Error reading: %@", [error localizedDescription]);
        } else {
            NSArray *rowsArr = [content componentsSeparatedByString:colDel];
            _rows = [rowsArr count];
            _cols = [[[rowsArr objectAtIndex:0] componentsSeparatedByString:rowDel] count];
            
            for (NSString *row in rowsArr)
                for (NSString *cell in [row componentsSeparatedByString:rowDel]) {
                    [_matrix addObject:parser(cell)];
                }
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
    
    for (int i=0; i<_rows; i++) {
        for (int j=0; j<_cols; j++) {
            id obj = [self objectAtRow:i column:j];
            [s appendString:coder(obj)];
            if (j != _cols-1) {
                [s appendString:rowDel];
            }
        }
        if (i != _rows-1) {
            [s appendString:colDel];
        }
    }
    
    NSError *error = nil;
    NSString *folder = pathDir(path);
    if (![[NSFileManager defaultManager] fileExistsAtPath:folder]) {
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
    BOOL rowCheck = (index.row >= 0) && (index.row < _rows);
    BOOL colCheck = (index.section >= 0) && (index.section < _cols);
    
    return rowCheck && colCheck;
}

- (int)posForIndex:(NSIndexPath *)index
{
    return index.row*_cols + index.section;
}

- (NSIndexPath *)indexForPos:(int)pos
{
    int i = (pos - pos%_cols)/_cols;
    int j = pos%_cols;
    return [NSIndexPath indexPathForItem:i inSection:j];
}

- (id)objectAtIndex:(NSIndexPath *)index
{
    if (![self containsIndex:index]) return nil;
    
    int pos = [self posForIndex:index];
    return [_matrix objectAtIndex:pos];
}

- (id)objectAtRow:(NSInteger)row
         column:(NSInteger)col
{
    NSIndexPath *p = [NSIndexPath indexPathForItem:row inSection:col];
    return [self objectAtIndex:p];
}

- (void)replaceObjectAtIndex:(NSIndexPath *)index withObject:(id)anObject
{
    if (![self containsIndex:index]) return;
    _matrix[[self posForIndex:index]] = anObject;
}

- (void)mapIndicesToBlock:(void (^)(NSIndexPath *))block
{
    for (int i=0; i<[_matrix count]; ++i)
        block([self indexForPos:i]);
}

- (NSMutableArray *)matrix
{
    return _matrix;
}

@end
