//
//  CalDay.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalDay.h"
#import "DateUtil.h"
#import "AZCalendarEnum.h"

#define SECOND_OF_A_DAY 24*60*60

@interface CalDay ()

- (void)calculateDate;
@end

@implementation CalDay

@synthesize date;

- (void)calculateDate {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:_date];
    day.month = comps.month;
    day.day = comps.day;
    day.year = comps.year;
    day.weekDay = comps.weekday;//[gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:_date];
}

- (id)initWithDate:(NSDate *)d {
    self = [super init];
    if (self){
        _date = d;
        [self calculateDate];
    }
    return self;
}

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)d {
    self = [super init];
    if (self){
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:d];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        _date = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:comps];
        [self calculateDate];
    }
    return self;
}

- (void)dealloc {
    _date = nil;
}

- (NSDate *)date {
    return _date;
}

- (NSUInteger)getYear {
    return day.year;
}

- (NSUInteger)getMonth {
    return day.month;
}

- (NSUInteger)getDay {
    return day.day;
}

- (NSUInteger)getWeekDay {
    return day.weekDay;
}

- (NSComparisonResult)compare:(CalDay *)calDay {
    NSComparisonResult result = NSOrderedSame;
    if ([self getYear] < [calDay getYear]){
        result = NSOrderedAscending;
    } else if ([self getYear] == [calDay getYear]){
        if ([self getMonth] < [calDay getMonth]){
            result = NSOrderedAscending;
        } else if ([self getMonth] == [calDay getMonth]){
            if ([self getDay] < [calDay getDay]){
                result = NSOrderedAscending;
            } else if ([self getDay] == [calDay getDay]){
                result = NSOrderedSame;
            } else {
                result = NSOrderedDescending;
            }
        } else {
            result = NSOrderedDescending;
        }
    } else {
        result = NSOrderedDescending;
    }
    return result;
}

- (CalDay *)nextDay {
    NSDate *nextDayDate = [_date dateByAddingTimeInterval:SECOND_OF_A_DAY];
    CalDay *nextDay = [[CalDay alloc] initWithDate:nextDayDate];
    return nextDay;
}

- (CalDay *)previousDay {
    NSDate *previousDayDate = [_date dateByAddingTimeInterval:-1 * SECOND_OF_A_DAY];
    CalDay *previousDay = [[CalDay alloc] initWithDate:previousDayDate];
    return previousDay;
}

- (WeekDay)getMeaningfulWeekDay {
    WeekDay wd = WeekDayKnown;
    switch (day.weekDay) {
        case 1:
            wd = WeekDaySunday;
            break;
        case 2:
            wd = WeekDayMonday;
            break;
        case 3:
            wd = WeekDayTuesday;
            break;
        case 4:
            wd = WeekDayWednesday;
            break;
        case 5:
            wd = WeekDayThursday;
            break;
        case 6:
            wd = WeekDayFriday;
            break;
        case 7:
            wd = WeekDaySaturday;
            break;
        default:
            break;
    }
    return wd;
}

- (NSString *)getWeekDayName {
    NSString *name = @"KnownName";
    switch (day.weekDay) {
        case 1:
            name = @"Sunday";
            break;
        case 2:
            name = @"Monday";
            break;
        case 3:
            name = @"Tuesday";
            break;
        case 4:
            name = @"Wednesday";
            break;
        case 5:
            name = @"Thurday";
            break;
        case 6:
            name = @"Friday";
            break;
        case 7:
            name = @"Saturday";
            break;
        default:
            break;
    }
    return name;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"year:%d month:%d day:%d week:%d %@", day.year, day.month, day.day, [self getMeaningfulWeekDay], [self getWeekDayName]];
}

- (BOOL)isToday {
    return ([DateUtil getCurrentYear] == day.year &&
        [DateUtil getCurrentMonth] == day.month &&
        [DateUtil getCurrentDay] == day.day);
}

- (BOOL)isEqualToDay:(CalDay *)calDay {
    BOOL equal = FALSE;
    if (calDay){
        equal = ([calDay getYear] == day.year &&
            [calDay getMonth] == day.month &&
            [calDay getDay] == day.day);
    }
    return equal;
}
@end
