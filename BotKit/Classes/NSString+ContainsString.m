//
//  NSString+ContainsString.m
//  BotKit
//
//  Created by Diana Zmuda on 11/19/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "NSString+ContainsString.h"

@implementation NSString (ContainsString)

- (BOOL)containsString:(NSString *)string
{
    if ([self rangeOfString:string].location == NSNotFound)
        return NO;
    
    return YES;
}

- (BOOL)containsStrings:(NSArray *)strings
{
    __block BOOL containsStrings = YES;
    
    [strings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = obj;
        
        if (![self containsString:string])
        {
            containsStrings = NO;
            *stop = YES;
        }
    }];
    
    return containsStrings;
}

@end
