//
//  NSArray+BotKitAdditions.h
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

@interface NSArray (ObjectAccess)

- (id)firstObject;

- (id)randomObject;

/**
 Chooses a random element using the weights array to determine their chance of being chosen.
 @param weights: array of numbers representing the chance each element has to be chosen. Each element of weights will be divided by sum(weights)
 @return an object from this array.
 */
- (id)randomObjectUsingWeights:(NSArray *)weights;

/**
 Same as randomObjectUsingWeights:, but you pass in a C array instead
 @param weights: C array (should be memory aligned) and have the same length as this array.
 @return an object from this array.
 */
- (id)randomObjectUsingFastWeights:(float *)weights;

@end
