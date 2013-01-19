//
//  BKMathStructs.h
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

typedef struct BKMatrixDimension
{
    NSInteger rows;
    NSInteger cols;
} BKMatrixDimension;

static inline BKMatrixDimension BKMatrixDimensionMake(NSInteger rows, NSInteger cols)
{
    BKMatrixDimension dim; dim.rows = rows; dim.cols = cols; return dim;
}