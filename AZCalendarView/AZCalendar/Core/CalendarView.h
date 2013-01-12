//
//  CalendarView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"
#import "CalendarViewDataSource.h"
#import "CalendarViewDelegate.h"
#import "CalendarGridView.h"
#import "CalendarViewHeaderView.h"
#import "CalendarViewFooterView.h"
#import "CalendarScrollView.h"

@class CalDay;
@class CalMonth;

@interface CalendarView : UIView <CalendarGridViewDelegate,
    CalendarViewHeaderViewDelegate, CalendarViewFooterViewDelegate, CalendarScrollViewDelegate> {

    bool **_selectedIndicesMatrix;
    bool **_focusMatrix;

    BOOL _moved;
    BOOL _firstLayout;
    BOOL _allowsMultipleSelection;

    NSTimeInterval _beginTimeInterval;
    CGPoint _beginPoint;

    PeriodType _selectedPeriod;

    GridIndex _previousSelectedIndex;

    CGSize _gridSize;

    NSDate *_date;
    NSDate *_minimumDate;
    NSDate *_maximumDate;

    CalDay *_minimumDay;
    CalDay *_maximumDay;
    CalDay *_selectedDay;

    CalMonth *_calMonth;

    CalendarViewHeaderView *_calendarHeaderView;
    CalendarViewFooterView *_calendarFooterView;

    NSMutableArray *_gridViewsArray;                   //two-dimensional array
    // =>
    NSMutableArray *_monthGridViewsArray;
    NSMutableDictionary *_recycledGridSetDic;

    id <CalendarViewDataSource> _dataSource;
    id <CalendarViewDelegate> _delegate;
}

@property(nonatomic, strong) id <CalendarViewDataSource> dataSource;
@property(nonatomic, strong) id <CalendarViewDelegate> delegate;

@property(nonatomic, assign) PeriodType selectedPeriod;
/*
 * default is FALSE
 */
@property(nonatomic, assign) BOOL allowsMultipleSelection;
@property(nonatomic, assign, getter=isAppear) BOOL appear;
/*
 * default date is current date
 */
@property(nonatomic, strong) NSDate *date;
/*
 * The minimum date that a date calendar view can show
 */
@property(nonatomic, strong) NSDate *minimumDate;
/*
 * The maximum date that a date calendar view can show
 */
@property(nonatomic, strong) NSDate *maximumDate;
/*
 * The selected calyday on calendar view
 */
@property(strong, nonatomic, readonly) CalDay *selectedDay;
/*
 * The selected date on calendar view
 */
@property(strong, nonatomic, readonly) NSDate *selectedDate;
/*
 * nil will be returned is allowsMultipleSelection is FALSE. 
 * Otherwise, an autorelease array of NSDate will be returned.
 */
@property(strong, nonatomic, readonly) NSArray *selectedDateArray;
/*
    The Grid Size
 */
@property(nonatomic, assign) CGSize gridSize;
/*
    Calendar Swipe timer Interval
 */
@property(nonatomic) CGFloat swipeTimeInterval;

/*
    if CalendarView height(actually) < CalendarView.xib height,
        CalendarView.xib height = CalendarView height(actually)

    default : YES
 */
@property(nonatomic, assign) BOOL autoresizesHeight;
/*
    if YES, Calendar Height is always same height.
    if Calendar row is 4 , automatic adding 5th row
    default : YES
 */
@property(nonatomic, assign) BOOL alwaysSameHeight;

/*
    All Calendar GridViews
    visibleGridViews is include BaseCalendarGridView and BaseCalendarDisableGridView
 */
@property(nonatomic, strong, readonly) NSArray *visibleGridViews;


- (void)nextMonth;

- (void)previousMonth;

- (void)show:(BOOL)animated;

- (void)show;

- (void)showInView:(UIView *)view;

- (void)hide:(BOOL)animated;

- (void)hide;

// reload DataSource - call <CalendarViewDataSource> methods
- (void)reloadData;

- (CalDay *)calDayAtGridIndex:(GridIndex)gridIndex;

- (GridIndex)gridIndexForGridView:(CalendarGridView *)gridView;

- (CalendarGridView *)dequeueCalendarGridViewWithIdentifier:(NSString *)identifier;

+ (id)viewFromNib;

@end
