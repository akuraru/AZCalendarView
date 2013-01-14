//
//  CalendarDataSource.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AZCalendarViewHeaderView;
@class AZCalendarViewFooterView;
@class AZCalendarGridView;
@class AZCalendarView;
@class AZCalMonth;
@class AZCalDay;
@class AZCalendarWeekHintView;

@protocol AZCalendarViewDataSource <NSObject>

@optional
- (NSArray *)weekTitlesForCalendarView:(AZCalendarView *)calendarView;
//- (NSString*) calendarView:(AZCalendarView*)calendarView titleForCellAtRow:(NSInteger)row column:(NSInteger)column calDay:(AZCalDay*)calDay;

- (NSString *)calendarView:(AZCalendarView *)calendarView titleForMonth:(AZCalMonth *)calMonth;

- (AZCalendarGridView *)calendarView:(AZCalendarView *)calendarView calendarGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(AZCalDay *)calDay;

- (AZCalendarGridView *)calendarView:(AZCalendarView *)calendarView calendarDisableGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(AZCalDay *)calDay;

- (AZCalendarViewHeaderView *)headerViewForCalendarView:(AZCalendarView *)calendarView;

- (AZCalendarViewFooterView *)footerViewForCalendarView:(AZCalendarView *)calendarView;

- (AZCalendarWeekHintView *)weekHintViewForCalendarView:(AZCalendarView *)calendarView;

// call before layout gridView
- (void)gridViewWillLayout:(AZCalendarView *)calendarView month:(AZCalMonth *)calMonth;
/*
    この間で上記のCalendar部品のdelegateが呼ばれカレンダーが構築される
 */
//  call after layout gridView
- (void)gridViewDidLayout:(AZCalendarView *)calendarView month:(AZCalMonth *)calMonth;
@end
