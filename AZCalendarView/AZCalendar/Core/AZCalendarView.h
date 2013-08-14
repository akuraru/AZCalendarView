//
//  AZCalendarView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"
#import "AZCalendarViewDataSource.h"
#import "AZCalendarViewDelegate.h"
#import "AZCalendarGridView.h"
#import "AZCalendarViewHeaderView.h"
#import "AZCalendarViewFooterView.h"
#import "AZCalendarScrollView.h"

#ifndef AZ_ENABLE_RECORD_LOGGING
    #ifdef DEBUG
        #define AZ_ENABLE_RECORD_LOGGING 1
    #else
        #define AZ_ENABLE_RECORD_LOGGING 0
    #endif
#endif
#if AZ_ENABLE_RECORD_LOGGING != 0
    #define AZLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#else
    #define AZLog(...) ((void)0)
#endif

@class AZCalDay;

@interface AZCalendarView : UIView <CalendarGridViewDelegate,
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

    AZCalDay *_minimumDay;
    AZCalDay *_maximumDay;
    AZCalDay *_selectedDay;

    AZCalMonth *_calMonth;

    AZCalendarViewHeaderView *_calendarHeaderView;
    AZCalendarViewFooterView *_calendarFooterView;

    NSMutableArray *_gridViewsArray;                   //two-dimensional array
    NSMutableArray *_monthGridViewsArray;
    NSMutableDictionary *_recycledGridSetDic;

    id <AZCalendarViewDataSource> _dataSource;
    id <AZCalendarViewDelegate> _delegate;
}

// for override
@property(strong, nonatomic) UIView *weekHintView;
@property(strong, nonatomic) UIView *headerView;
@property(strong, nonatomic) AZCalendarScrollView *gridScrollView;
@property(strong, nonatomic) UIView *footerView;

@property(nonatomic, strong) id <AZCalendarViewDataSource> dataSource;
@property(nonatomic, strong) id <AZCalendarViewDelegate> delegate;

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
 * The selected calDay on calendar view
 */
@property(strong, nonatomic, readonly) AZCalDay *selectedDay;
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
    Default(When doesn't assign): use BaseCalendarGridView.xib size
 */
@property(nonatomic, assign) CGSize gridSize;
/*
    Calendar Swipe timer Interval
 */
@property(nonatomic) CGFloat swipeTimeInterval;

/*
    if AZCalendarView height(actually) < BaseCalendarView.xib height,
        BaseCalendarView.xib height = AZCalendarView height(actually)

    default : YES
 */
@property(nonatomic, assign) BOOL adjustsScrollViewToFitHeight;
/*
    if YES, gridScrollView height is always same height - When Calendar row is 4 , automatic adding 5th row.
    default : YES
 */
@property(nonatomic, assign) BOOL autoAddNewRowOfCalendar;
/*
    decide gridView & weekHintView Width from gridSize of Xib.
    cf.  gridSize of Xib is gridSize property.
    default : NO , width is self.bound.size.width / NUMBER_OF_DAYS_IN_WEEK;
 */
@property(nonatomic) BOOL decideGridWidthAccordingToXib;
/*
    All Calendar GridViews
    visibleGridViews is include BaseCalendarGridView and BaseCalendarDisableGridView
 */
@property(nonatomic, strong, readonly) NSArray *visibleGridViews;


- (void)nextMonth __attribute__ ((deprecated));
- (void)showNextMonth;

- (void)previousMonth __attribute__ ((deprecated));
- (void)showPreviousMonth;

- (void)show:(BOOL)animated;

- (void)show;

/*
    - (void) show + addSubView
 */
- (void)showInView:(UIView *)view;

- (void)hide:(BOOL)animated;

- (void)hide;

/*
    reload DataSource
    call <AZCalendarViewDataSource> methods
*/
- (void)reloadData;

- (AZCalDay *)calDayAtGridIndex:(GridIndex)gridIndex;

- (GridIndex)gridIndexForGridView:(AZCalendarGridView *)gridView;

- (AZCalendarGridView *)dequeueCalendarGridViewWithIdentifier:(NSString *)identifier;

+ (id)viewFromNib;

@end
