//
//  BaseDataSourceImp.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "BaseDataSourceImp.h"
#import "BaseCalendarGridView.h"
#import "BaseCalendarDisableGridView.h"
#import "BaseCalendarViewHeaderView.h"
#import "CalMonth.h"
#import "CalendarWeekHintView.h"
#import "BaseCalendarWeekHintView.h"
#import "CalendarView.h"
#import "BaseCalendarViewFooterView.h"

@implementation BaseDataSourceImp {
}


#pragma mark - update cell
- (void)updateVisibleCells {
    // セルの表示更新
}


- (void)updateGridView:(CalendarGridView *)calendarView calendarGridViewForRow:(NSInteger)row
        column:(NSInteger)column calDay:(CalDay *)calDay {
}

#pragma mark - dataSource delegate
- (void)gridViewWillLayout:(CalendarView *)calendarView month:(CalMonth *)calMonth {
}

- (void)gridViewDidLayout:(CalendarView *)calendarView month:(CalMonth *)calMonth {

}

#pragma mark - build UI
- (CalendarViewHeaderView *)headerViewForCalendarView:(CalendarView *)calendarView {
    return [BaseCalendarViewHeaderView viewFromNib];
}

// Sun,Mon,Tsu ...
- (CalendarWeekHintView *)weekHintViewForCalendarView:(CalendarView *)calendarView {
    return [BaseCalendarWeekHintView viewFromNib];
}

- (CalendarGridView *)calendarView:(CalendarView *)calendarView calendarGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(CalDay *)calDay {
    static NSString *identifier = @"BaseCalendarGridView";
    CalendarGridView *gridView = [calendarView dequeueCalendarGridViewWithIdentifier:identifier];
    if (!gridView){
        gridView = [BaseCalendarGridView viewFromNibWithIdentifier:identifier];
    }
    [self updateGridView:gridView calendarGridViewForRow:row column:column calDay:calDay];
    return gridView;
}

- (CalendarGridView *)calendarView:(CalendarView *)calendarView calendarDisableGridViewForRow:(NSInteger)row
                      column:(NSInteger)column calDay:(CalDay *)calDay {
    static NSString *identifier = @"BaseCalendarDisableGridView";
    CalendarGridView *gridView = [calendarView dequeueCalendarGridViewWithIdentifier:identifier];
    if (!gridView){
        gridView = [BaseCalendarDisableGridView viewFromNibWithIdentifier:identifier];
    }
    return gridView;
}

/*
- (NSArray *)weekTitlesForCalendarView:(CalendarView *)calendarView {
    return nil;

}
*/
//- (CalendarViewFooterView *)footerViewForCalendarView:(CalendarView *)calendarView {
//    return [BaseCalendarViewFooterView viewFromNib];
//}


- (NSString *)calendarView:(CalendarView *)calendarView titleForMonth:(CalMonth *)calMonth {
    NSString *title = [NSString stringWithFormat:@"%d/%d", [calMonth getYear], [calMonth getMonth]];
    return title;
}
@end
