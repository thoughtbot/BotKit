//
//  NSDate+BotKitAdditions.h
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

@interface NSDate (RelativeDates)

// Represents 00:00:00 on the following date
+ (NSDate *)tomorrow;

// Represents 00:00:00 on the previous date
+ (NSDate *)yesterday;

// Returns midnight for the current date
- (NSDate *)midnight;

// Determines if the receiver falls between 00:00:00 and 23:59:59 for the current date
- (BOOL)isToday;
- (BOOL)isBeforeDate:(NSDate *)date;
- (BOOL)isAfterDate:(NSDate *)date;

@end
