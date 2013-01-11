//
//  CalDay.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"

@interface CalDay : NSObject {
@private
    struct {
        unsigned int month : 4;
        unsigned int day : 5;
        unsigned int year : 15;
        unsigned int weekDay : 4;        //sunday-saturday 1-7
    } day;
}

- (id)initWithDate:(NSDate *)date;

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@property(nonatomic, strong, readonly) NSDate *date;

- (NSUInteger)getYear;

- (NSUInteger)getMonth;

- (NSUInteger)getDay;

- (NSUInteger)getWeekDay;

- (NSComparisonResult)compare:(CalDay *)calDay;

- (CalDay *)nextDay;

- (CalDay *)previousDay;

- (WeekDay)getMeaningfulWeekDay;

- (NSString *)getWeekDayName;

- (BOOL)isToday;

- (BOOL)isEqualToDay:(CalDay *)calDay;

@end
