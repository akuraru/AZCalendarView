//
//  CalDay.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalDay.h"
#import "DateUtil.h"

#define SECOND_OF_A_DAY 24*60*60

@interface CalDay ()

@property(nonatomic, strong, readwrite) NSDate *date;

- (void)defineDayOfDate;
@end

@implementation CalDay


- (void)setDate:(NSDate *)date {
    _date = date;
    // Calculate struct Day
    [self defineDayOfDate];
}

- (void)defineDayOfDate {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSAssert(self.date != nil, @"self.date is nil");
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self.date];
    day.month = (unsigned int) comps.month;
    day.day = (unsigned int) comps.day;
    day.year = (unsigned int) comps.year;
    day.weekDay = (unsigned int) comps.weekday;
}

- (id)initWithDate:(NSDate *)date {
    self = [super init];
    if (self){
        self.date = date;
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
        self.date = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:comps];
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
    NSDate *nextDayDate = [self.date dateByAddingTimeInterval:SECOND_OF_A_DAY];
    CalDay *nextDay = [[CalDay alloc] initWithDate:nextDayDate];
    return nextDay;
}

- (CalDay *)previousDay {
    NSDate *previousDayDate = [self.date dateByAddingTimeInterval:-1 * SECOND_OF_A_DAY];
    CalDay *previousDay = [[CalDay alloc] initWithDate:previousDayDate];
    return previousDay;
}

- (WeekDay)getMeaningfulWeekDay {
    WeekDay weekDay = WeekDayKnown;
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
    if (day.weekDay == 0){
        return @"UNKNOWN_WEEK_DAY_NAME";
    }
    return [[dateFormatter weekdaySymbols] objectAtIndex:day.weekDay - 1];
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
    NSAssert([calDay isKindOfClass:[CalDay class]], @"Arguments is not CalDay");
    BOOL equal = ([calDay getYear] == day.year &&
        [calDay getMonth] == day.month &&
        [calDay getDay] == day.day);
    return equal;
}
@end
