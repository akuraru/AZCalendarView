//
//  CalendarDataSource.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalendarViewHeaderView;
@class CalendarViewFooterView;
@class CalendarGridView;
@class CalendarView;
@class CalMonth;
@class CalDay;
@class CalendarWeekHintView;

@protocol CalendarViewDataSource <NSObject>

@optional
- (NSArray *)weekTitlesForCalendarView:(CalendarView *)calendarView;
//- (NSString*) calendarView:(CalendarView*)calendarView titleForCellAtRow:(NSInteger)row column:(NSInteger)column calDay:(CalDay*)calDay;

- (NSString *)calendarView:(CalendarView *)calendarView titleForMonth:(CalMonth *)calMonth;

- (CalendarGridView *)calendarView:(CalendarView *)calendarView calendarGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(CalDay *)calDay;

- (CalendarGridView *)calendarView:(CalendarView *)calendarView calendarDisableGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(CalDay *)calDay;

- (CalendarViewHeaderView *)headerViewForCalendarView:(CalendarView *)calendarView;

- (CalendarViewFooterView *)footerViewForCalendarView:(CalendarView *)calendarView;

- (CalendarWeekHintView *)weekHintViewForCalendarView:(CalendarView *)calendarView;

// layout が 始まる前に呼び出される
- (void)gridViewWillLayout:(CalendarView *)calendarView month:(CalMonth *)calMonth;
/*
    この間で上記のCalendar部品のdelegateが呼ばれカレンダーが構築される
 */
// layout が 終わった時に呼び出される
- (void)gridViewDidLayout:(CalendarView *)calendarView month:(CalMonth *)calMonth;
@end
