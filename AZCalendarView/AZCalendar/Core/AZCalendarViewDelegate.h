//
//  CalendarDelegate.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZCalendarEnum.h"
@class AZCalendarView;
@class AZCalDay;

@protocol AZCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(AZCalendarView *)calendarView didSelectDay:(AZCalDay *)calDay;
- (void)calendarView:(AZCalendarView *)calendarView didSelectPeriodType:(PeriodType)periodType;
@end
