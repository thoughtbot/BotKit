//
//  NSCountedSet+ObjectAccess.h
//  BotKit
//
//  Created by theo on 1/31/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

@interface NSCountedSet (ObjectAccess)

- (id)randomObject;
- (id)randomObjectUsingCountsAsWeights;

- (id)objectWithHighestCount;
- (id)objectWithLowestCount;
- (NSArray *)objectsWithHighestCounts:(NSInteger)numberOfObjects;

- (NSInteger)countAllObjects;

- (NSArray *)allObjectsFlattened;

@end
