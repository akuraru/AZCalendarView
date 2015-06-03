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
#import "AZCalMonth.h"
#import "AZCalendarWeekHintView.h"
#import "BaseCalendarWeekHintView.h"
#import "AZCalendarView.h"

@implementation BaseDataSourceImp

#pragma mark - dataSource delegate
- (void)gridViewWillLayout:(AZCalendarView *)calendarView month:(AZCalMonth *)calMonth {
}

- (void)gridViewDidLayout:(AZCalendarView *)calendarView month:(AZCalMonth *)calMonth {

}

#pragma mark - update cell
- (void)updateGridView:(AZCalendarGridView *)gridView calendarGridViewForRow:(NSInteger)row
        column:(NSInteger)column calDay:(AZCalDay *)calDay {

    BaseCalendarGridView *baseGridView = (BaseCalendarGridView *) gridView;
    baseGridView.recordImageView.hidden = (row != 0);
}

#pragma mark - build UI
- (AZCalendarViewHeaderView *)headerViewForCalendarView:(AZCalendarView *)calendarView {
    return [BaseCalendarViewHeaderView viewFromNib];
}

// Sun,Mon,Tsu ...
- (AZCalendarWeekHintView *)weekHintViewForCalendarView:(AZCalendarView *)calendarView {
    return [BaseCalendarWeekHintView viewFromNib];
}

- (AZCalendarGridView *)calendarView:(AZCalendarView *)calendarView calendarGridViewForRow:(NSInteger)row
                        column:(NSInteger)column calDay:(AZCalDay *)calDay {
    static NSString *identifier = @"BaseCalendarGridView";
    AZCalendarGridView *gridView = [calendarView dequeueCalendarGridViewWithIdentifier:identifier];
    if (!gridView){
        gridView = [BaseCalendarGridView viewFromNibWithIdentifier:identifier];
    }
    [self updateGridView:gridView calendarGridViewForRow:row column:column calDay:calDay];

    return gridView;
}

- (AZCalendarGridView *)calendarView:(AZCalendarView *)calendarView calendarDisableGridViewForRow:(NSInteger)row
                        column:(NSInteger)column calDay:(AZCalDay *)calDay {
    static NSString *identifier = @"BaseCalendarDisableGridView";
    AZCalendarGridView *gridView = [calendarView dequeueCalendarGridViewWithIdentifier:identifier];
    if (!gridView){
        gridView = [BaseCalendarDisableGridView viewFromNibWithIdentifier:identifier];
    }
    return gridView;
}

/*
- (NSArray *)weekTitlesForCalendarView:(AZCalendarView *)calendarView {
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
}

- (AZCalendarViewFooterView *)footerViewForCalendarView:(AZCalendarView *)calendarView {
    return [BaseCalendarViewFooterView viewFromNib];
}
*/

- (NSString *)calendarView:(AZCalendarView *)calendarView titleForMonth:(AZCalMonth *)calMonth {
    NSString *title = [NSString stringWithFormat:@"%tu/%tu", [calMonth getYear], [calMonth getMonth]];
    return title;
}
@end
