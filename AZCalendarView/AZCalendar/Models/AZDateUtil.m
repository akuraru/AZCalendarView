//
//  AZDateUtil.m
//  AZCalendar
//
// Created by azu on 2013/03/28.
//

#import "AZDateUtil.h"

@implementation AZDateUtil

+ (NSCalendar *)getCurrentCalendar {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return calendar;
}

+ (NSInteger)getCurrentYear {
    NSDateComponents *components = [[self getCurrentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    return components.year;
}

+ (NSInteger)getCurrentMonth {
    NSDateComponents *components = [[self getCurrentCalendar] components:NSMonthCalendarUnit fromDate:[NSDate date]];
    return components.month;
}

+ (NSInteger)getCurrentDay {
    NSDateComponents *components = [[self getCurrentCalendar] components:NSDayCalendarUnit fromDate:[NSDate date]];
    return components.day;

}

+ (NSInteger)numberOfDaysInMonthDate:(NSDate *) date {
    NSCalendar *calendar = [self getCurrentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

@end
