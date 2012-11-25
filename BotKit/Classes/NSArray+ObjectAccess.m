//
//  NSArray+BotKitAdditions.m
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

#import "NSArray+ObjectAccess.h"

@implementation NSArray (ObjectAccess)

- (id)firstObject
{
    if (self.count <= 0)
        return nil;

    return [self objectAtIndex:0];
}

@end