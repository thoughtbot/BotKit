//
//  NSArray+Enumeration.m
//  BotKit
//
//  Created by Gordon Fontenot on 2/27/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "NSArray+Enumeration.h"

@implementation NSArray (Enumeration)

#pragma mark - Public Methods

- (NSArray *)mappedArrayWithBlock:(BKEnumerationBlock)enumerationBlock
{
    NSMutableArray *returnArray = [NSMutableArray array];

    for (id object in self) {
        id returnObject = enumerationBlock(object);

        if (returnObject) [returnArray addObject:returnObject];
    }

    return [NSArray arrayWithArray:returnArray];
}

- (NSArray *)arrayBySelectingObjectsWithBlock:(BKSelectionBlock)selectionBlock
{
    return [self filteredArrayWithComparisonBlock:selectionBlock shouldSelect:YES];
}

- (NSArray *)arrayByRejectingObjectsWithBlock:(BKSelectionBlock)selectionBlock
{
    return [self filteredArrayWithComparisonBlock:selectionBlock shouldSelect:NO];
}

#pragma mark - Private Methods

- (NSArray *)filteredArrayWithComparisonBlock:(BKSelectionBlock)comparisonBlock shouldSelect:(BOOL)shouldSelect
{
    NSMutableArray *returnArray = [NSMutableArray array];

    for (id object in self) {
        if (comparisonBlock(object) && shouldSelect) [returnArray addObject:object];
        else if (!comparisonBlock(object) && !shouldSelect) [returnArray addObject:object];
    }

    return [NSArray arrayWithArray:returnArray];
}

@end
