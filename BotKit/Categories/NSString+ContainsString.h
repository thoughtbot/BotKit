//
//  NSString+ContainsString.h
//  BotKit
//
//  Created by Diana Zmuda on 11/19/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

@interface NSString (ContainsString)

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsStrings:(NSArray *)strings;

@end
