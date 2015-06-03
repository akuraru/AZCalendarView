//
//  CalendarDelegate.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"

@class AZCalendarView;
@class AZCalDay;

@protocol AZCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(AZCalendarView *) calendarView didChangeDate:(NSDate *) date;
- (void)calendarView:(AZCalendarView *) calendarView didSelectDate:(NSDate *) date;

- (void)calendarView:(AZCalendarView *) calendarView didSelectDay:(AZCalDay *) calDay __attribute__((deprecated("Use - (void)calendarView:didChangeDate: instead")));
@end
