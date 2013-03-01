//
//  NSArray+Enumeration.m
//  BotKit
//
//  Created by Gordon Fontenot on 2/27/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "NSArray+Enumeration.h"

@implementation NSArray (Enumeration)

- (NSArray *)mappedArrayWithBlock:(BKEnumerationBlock)enumerationBlock
{
    NSMutableArray *returnArray = [NSMutableArray array];

    for (id object in self) {
        id returnObject = enumerationBlock(object);

        if (returnObject) [returnArray addObject:returnObject];
    }

    return [NSArray arrayWithArray:returnArray];
}

- (NSArray *)selectedArrayWithBlock:(BKSelectionBlock)selectionBlock
{
    NSMutableArray *returnArray = [NSMutableArray array];

    for (id object in self) {
        if (selectionBlock(object)) [returnArray addObject:object];
    }

    return [NSArray arrayWithArray:returnArray];
}

- (NSArray *)rejectedArrayWithBlock:(BKSelectionBlock)selectionBlock
{
    NSMutableArray *returnArray = [NSMutableArray array];

    for (id object in self) {
        if (!selectionBlock(object)) [returnArray addObject:object];
    }

    return [NSArray arrayWithArray:returnArray];
}

@end
