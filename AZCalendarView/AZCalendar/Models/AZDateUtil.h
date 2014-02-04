//
//  AZDateUtil.h
//  AZCalendar
//
// Created by azu on 2013/03/28.
//

#import <Foundation/Foundation.h>

@interface AZDateUtil : NSObject

+ (NSInteger)getCurrentYear;

+ (NSInteger)getCurrentMonth;

+ (NSInteger)getCurrentDay;

+ (NSInteger)numberOfDaysInMonthDate:(NSDate *) date;

@end
