//
//  AZCalDay.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "AZCalDay.h"
#import "AZDateUtil.h"

#define SECOND_OF_A_DAY 24*60*60

@interface AZCalDay ()

@property(nonatomic, strong, readwrite) NSDate *date;

- (void)defineDayOfDate;

- (WeekDay)getMeaningfulWeekDay;

- (NSString *)getWeekDayName;
@end

@implementation AZCalDay


- (void)setDate:(NSDate *) date {
    _date = date;
    // Calculate struct Day
    [self defineDayOfDate];
}

- (void)defineDayOfDate {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSAssert(self.date != nil, @"self.date is nil");
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self.date];
    day.month = (unsigned int)comps.month;
    day.day = (unsigned int)comps.day;
    day.year = (unsigned int)comps.year;
    day.weekDay = (unsigned int)comps.weekday;
}

- (id)initWithDate:(NSDate *) date {
    self = [super init];
    if (self) {
        self.date = date;
    }
    return self;
}

- (id)initWithYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) d {
    self = [super init];
    if (self != nil) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:d];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        self.date = [calendar dateFromComponents:comps];
    }
    return self;
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

- (NSComparisonResult)compare:(AZCalDay *) calDay {
    NSComparisonResult result = NSOrderedSame;
    if ([self getYear] < [calDay getYear]) {
        result = NSOrderedAscending;
    } else if ([self getYear] == [calDay getYear]) {
        if ([self getMonth] < [calDay getMonth]) {
            result = NSOrderedAscending;
        } else if ([self getMonth] == [calDay getMonth]) {
            if ([self getDay] < [calDay getDay]) {
                result = NSOrderedAscending;
            } else if ([self getDay] == [calDay getDay]) {
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

- (AZCalDay *)nextDay {
    NSDate *nextDayDate = [self.date dateByAddingTimeInterval:SECOND_OF_A_DAY];
    AZCalDay *nextDay = [[AZCalDay alloc] initWithDate:nextDayDate];
    return nextDay;
}

- (AZCalDay *)previousDay {
    NSDate *previousDayDate = [self.date dateByAddingTimeInterval:-1 * SECOND_OF_A_DAY];
    AZCalDay *previousDay = [[AZCalDay alloc] initWithDate:previousDayDate];
    return previousDay;
}

- (WeekDay)getMeaningfulWeekDay {
    WeekDay weekDay = WeekDayUNKnown;
    switch (day.weekDay) {
        case 1:
            weekDay = WeekDaySunday;
            break;
        case 2:
            weekDay = WeekDayMonday;
            break;
        case 3:
            weekDay = WeekDayTuesday;
            break;
        case 4:
            weekDay = WeekDayWednesday;
            break;
        case 5:
            weekDay = WeekDayThursday;
            break;
        case 6:
            weekDay = WeekDayFriday;
            break;
        case 7:
            weekDay = WeekDaySaturday;
            break;
        default:
            break;
    }
    return weekDay;
}

- (NSString *)getWeekDayName {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if (day.weekDay == 0) {
        return @"UNKNOWN_WEEK_DAY_NAME";
    }
    return [[dateFormatter weekdaySymbols] objectAtIndex:day.weekDay - 1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"year:%d month:%d day:%d week:%d %@", day.year, day.month, day.day, [self getMeaningfulWeekDay], [self getWeekDayName]];
}

- (BOOL)isToday {
    return ([AZDateUtil getCurrentYear] == day.year &&
            [AZDateUtil getCurrentMonth] == day.month &&
            [AZDateUtil getCurrentDay] == day.day);
}

- (BOOL)isEqualToDay:(AZCalDay *) calDay {
    NSAssert([calDay isKindOfClass:[AZCalDay class]], @"Arguments is not AZCalDay");
    BOOL equal = ([calDay getYear] == day.year &&
            [calDay getMonth] == day.month &&
            [calDay getDay] == day.day);
    return equal;
}
@end
