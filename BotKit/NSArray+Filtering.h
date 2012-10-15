//
//  NSArray+Filtering.h
//  BotKit
//
//  Created by Mark Adams on 10/15/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

@interface NSArray (Filtering)

- (NSArray *)filteredArrayWhereValuesForKeys:(NSArray *)keys beginWithString:(NSString *)string;
- (NSArray *)filteredArrayWhereValuesForKeys:(NSArray *)keys beginWithString:(NSString *)string caseInsensitive:(BOOL)caseInsensitive diacritical:(BOOL)diacritical;

@end
