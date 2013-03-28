//
//  AZCalMonth.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "AZCalMonth.h"
#import "AZDateUtil.h"
#import "AZCalDay.h"

#define FIRST_MONTH_OF_YEAR  1
#define LAST_MONTH_OF_YEAR  12

@interface AZCalMonth ()

- (void)calculateMonth;
@end

@implementation AZCalMonth

- (void)calculateMonth {
    mon.numberOfDays = (unsigned int) [AZDateUtil numberOfDaysInMonthDate:_today.date];
    mon.year = [_today getYear];
    mon.month = [_today getMonth];
    daysOfMonth = [[NSMutableArray alloc] init];
    for (NSInteger day = 1 ;day <= mon.numberOfDays ;day++){
        AZCalDay *calDay = [[AZCalDay alloc] initWithYear:mon.year month:mon.month day:day];
        [daysOfMonth addObject:calDay];
    }
}

- (AZCalMonth *)nextMonth {
    NSUInteger year = mon.year;
    NSUInteger month = mon.month + 1;
    NSUInteger day = 1;
    if (month > LAST_MONTH_OF_YEAR){
        year++;
        month = 1;
    }
    AZCalMonth *calMonth = [[AZCalMonth alloc] initWithMonth:month year:year day:day];
    return calMonth;
}

- (AZCalMonth *)previousMonth {
    NSUInteger year = mon.year;
    NSUInteger month = mon.month - 1;
    NSUInteger day = 1;
    if (month < FIRST_MONTH_OF_YEAR){
        year--;
        month = 12;
    }
    AZCalMonth *calMonth = [[AZCalMonth alloc] initWithMonth:month year:year day:day];
    return calMonth;
}

- (id)initWithMonth:(NSUInteger)month {
    self = [super init];
    if (self){
        _today = [[AZCalDay alloc] initWithYear:[AZDateUtil getCurrentYear] month:month day:1];
        [self calculateMonth];
    }
    return self;
}

- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year {
    self = [super init];
    if (self){
        _today = [[AZCalDay alloc] initWithYear:year month:month day:1];
        [self calculateMonth];
    }
    return self;
}

- (id)initWithDate:(NSDate *)date {
    self = [super init];
    if (self){
        _today = [[AZCalDay alloc] initWithDate:date];
        [self calculateMonth];
    }
    return self;
}

- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year day:(NSUInteger)day {
    self = [super init];
    if (self){
        _today = [[AZCalDay alloc] initWithYear:year month:month day:day];
        [self calculateMonth];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"year:%d month:%d number of days:%d",
                                      mon.year, mon.month, mon.numberOfDays];
}

- (NSUInteger)days {
    return mon.numberOfDays;
}

- (NSUInteger)getYear {
    return mon.year;
}

- (NSUInteger)getMonth {
    return mon.month;
}

- (AZCalDay *)calDayAtDay:(NSUInteger)day {
    NSInteger index = day - 1;
    NSAssert(!(index < 0 || index > 31), @"invalid day index %d", index);
    return [daysOfMonth objectAtIndex:(NSUInteger) index];
}

- (AZCalDay *)firstDay {
    return [daysOfMonth objectAtIndex:0];
}

- (AZCalDay *)lastDay {
    return [daysOfMonth objectAtIndex:mon.numberOfDays - 1];
}

- (void)dealloc {
    daysOfMonth = nil;
}
@end
