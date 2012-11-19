//
//  NSString+ContainsString.h
//  BotKit
//
//  Created by Diana Zmuda on 11/19/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ContainsString)

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsStrings:(NSArray *)strings;

@end
