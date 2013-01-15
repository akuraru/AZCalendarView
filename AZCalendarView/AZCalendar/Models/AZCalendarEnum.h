//
//  Enum.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-13.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#ifndef AZCalendar_Enum_h
#define AZCalendar_Enum_h

typedef enum {
    PeriodTypeKnown = 11,
    PeriodTypeAllDay,
    PeriodTypeMorning,
    PeriodTypeNoon,
    PeriodTypeAfternoon,
    PeriodTypeEvening
} PeriodType;

typedef enum {
    WeekDayUNKnown = 0,
    WeekDayMonday,
    WeekDayTuesday,
    WeekDayWednesday,
    WeekDayThursday,
    WeekDayFriday,
    WeekDaySaturday,
    WeekDaySunday
} WeekDay;

typedef struct {
    NSInteger row;
    NSInteger column;
} GridIndex;
#endif
