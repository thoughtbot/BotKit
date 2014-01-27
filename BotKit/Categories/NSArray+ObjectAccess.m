//
//  NSArray+BotKitAdditions.m
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

#import "NSArray+ObjectAccess.h"
#import <Accelerate/Accelerate.h>

static NSInteger const multiplier = 100000;

@implementation NSArray (ObjectAccess)

- (id)firstObject
{
    if (self.count <= 0)
        return nil;
    
    return [self objectAtIndex:0];
}

#pragma mark - Random Obj Accessing

- (id)randomObject
{
    return [self objectAtIndex:arc4random() % [self count]];
}

- (id)randomObjectUsingWeights:(NSArray *)weights
{
    NSAssert([weights count] == [self count], @"Weight array needs to be the same length as this array.");
    
    /* Set each element in weights to a percentage */
    NSInteger len = [self count];
    float *w = (float *)calloc(len, sizeof(float));
    
    for (int i = 0; i < len; ++i)
        w[i] = [weights[i] floatValue];
    
    return [self randomObjectUsingFastWeights:w];
}

- (id)randomObjectUsingFastWeights:(float *)weights
{
    NSInteger len = [self count];
    
    /* Set each element in weights to a percentage */
    float sum = 0.0;
    float *scaled = (float *)calloc(len, sizeof(float));
    
    vDSP_sve(weights, 1, &sum, len);
    vDSP_vsdiv(weights, 1, &sum, scaled, 1, len);
    
    /* Scale the numbers by the product of "multiple and weight[index]" */
    float *scaledFitness = (float *)calloc(len, sizeof(float));
    scaledFitness[0] = multiplier * scaled[0];
    
    for (int i = 1; i < len; ++i)
        scaledFitness[i] = scaledFitness[i-1] + multiplier * scaled[i];
    
    /* Do the picking */
    NSInteger randomSeed = arc4random() % (int)scaledFitness[len-1];
    
    NSInteger index = 0;
    NSInteger minDifference = NSIntegerMax;
    for (int i = 0; i < len; ++i) {
        NSInteger difference = (scaledFitness[i] - randomSeed);
        
        if (difference < minDifference && difference >= 0)
        {
            minDifference = difference;
            index = i;
        }
    }
    
    free(scaled);
    free(scaledFitness);
    
    return [self objectAtIndex:index];
}

@end
