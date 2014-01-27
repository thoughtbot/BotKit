//
//  NSDate+BotKitAdditions.m
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

#import "NSDate+RelativeDates.h"

@implementation NSDate (RelativeDates)

+ (NSDate *)tomorrow
{
    return [[NSDate dateThatIsNumberOfDaysFromToday:1] midnight];
}

+ (NSDate *)yesterday
{
    return [[NSDate dateThatIsNumberOfDaysFromToday:-1] midnight];
}

- (NSDate *)midnight
{
    NSDateComponents *components = [self dateComponents];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;

    return [[NSCalendar autoupdatingCurrentCalendar] dateFromComponents:components];
}

- (BOOL)isToday
{
    if ([self compare:[NSDate yesterday]] == NSOrderedDescending && [self compare:[NSDate tomorrow]] == NSOrderedAscending)
        return YES;

    return NO;
}

- (BOOL)isBeforeDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedAscending)
        return YES;

    return NO;
}

- (BOOL)isAfterDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedDescending)
        return YES;

    return NO;
}

#pragma mark - Private Helpers
+ (NSDate *)dateThatIsNumberOfDaysFromToday:(NSInteger)numberOfDays
{
    NSDateComponents *components = [[NSDate date] dateComponents];
    components.day = components.day + numberOfDays;

    return [[NSCalendar autoupdatingCurrentCalendar] dateFromComponents:components];
}

- (NSDateComponents *)dateComponents
{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger componentUnitFlags = (NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit);
    NSDateComponents *dateComponents = [calendar components:componentUnitFlags fromDate:self];

    return dateComponents;
}

@end
