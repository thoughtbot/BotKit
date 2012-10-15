//
//  NSArray+Filtering.m
//  BotKit
//
//  Created by Mark Adams on 10/15/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "NSArray+Filtering.h"

@implementation NSArray (Filtering)

- (NSArray *)filteredArrayWhereValuesForKeys:(NSArray *)keys beginWithString:(NSString *)string
{
    return [self filteredArrayWhereValuesForKeys:keys beginWithString:string caseInsensitive:NO diacritical:NO];
}

- (NSArray *)filteredArrayWhereValuesForKeys:(NSArray *)keys beginWithString:(NSString *)string caseInsensitive:(BOOL)caseInsensitive diacritical:(BOOL)diacritical
{
    NSMutableString *modifierString = [NSMutableString string];

    if (caseInsensitive || diacritical)
        [modifierString appendString:@"["];

    if (caseInsensitive)
        [modifierString appendString:@"c"];

    if (diacritical)
        [modifierString appendString:@"d"];

    if ([modifierString rangeOfString:@"["].location != NSNotFound)
        [modifierString appendString:@"]"];

    __block NSMutableString *formatString = [NSMutableString string];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        NSString *key = (NSString *)obj;
        BOOL lastIteration = (idx >= keys.count - 1) ? YES : NO;

        NSString *andString = @"AND";

        if (lastIteration)
            andString = @"";

        [formatString appendFormat:@"(%@ beginswith%@ %@) %@", key, modifierString, string, andString];

    }];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:[formatString copy]];

    return [self filteredArrayUsingPredicate:predicate];
}

@end
