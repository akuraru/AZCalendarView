//
//  AZCalendarView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.

#import <CoreGraphics/CoreGraphics.h>
#import "AZCalendarView.h"
#import "AZCalMonth.h"
#import "AZCalendarWeekHintView.h"

#define NUMBER_OF_DAYS_IN_WEEK  7
#define MARGIN_LEFT                              0
#define MARGIN_TOP                               0
#define PADDING_VERTICAL                         0
#define PADDING_HORIZONTAL                       0
#define HORIZONTAL_SWIPE_HEIGHT_CONSTRAINT       80
#define HORIZONTAL_SWIPE_WIDTH_CONSTRAINT        90
#define SWIPE_TIMER_INTERVAL                      0.4

@interface AZCalendarView ()

@property(strong, nonatomic) AZCalMonth *calMonth;

- (void)initParameters;

- (void)layoutGridCells;

- (void)recycleAllGridViews;

- (void)resetSelectedIndicesMatrix;

- (void)resetFocusMatrix;

- (void)updateSelectedGridViewState;

- (void)removeGridViewAtRow:(NSUInteger)row column:(NSUInteger)column;

- (void)addGridViewAtRow:(AZCalendarGridView *)gridView row:(NSUInteger)row column:(NSUInteger)column;

- (BOOL)isGridViewSelectedEnableAtRow:(NSUInteger)row column:(NSUInteger)column;

/*
 * caculate rows of calendar view based on month
 */
- (NSUInteger)getRows;

/*
 * caculate month day based on row and column on calendar view
 */
- (NSUInteger)getMonthDayAtRow:(NSUInteger)row column:(NSUInteger)column;

/*
 * caculate grid view frame based on row and column on calendar view
 */
- (CGRect)getFrameForRow:(NSUInteger)row column:(NSUInteger)column;

- (NSString *)findMonthDescription;

- (NSArray *)findWeekTitles;

/*
 * @return:current day or first day of a month
 */
- (AZCalDay *)getFirstSelectedAvailableDay;

- (AZCalendarViewHeaderView *)findHeaderView;

- (AZCalendarViewFooterView *)findFooterView;

- (AZCalendarGridView *)findGridViewAtRow:(NSUInteger)row column:(NSUInteger)column calDay:(AZCalDay *)calDay;

- (AZCalendarGridView *)findDisableGridViewAtRow:(NSUInteger)row column:(NSUInteger)column calDay:(AZCalDay *)calDay;

- (AZCalendarGridView *)getGridViewAtRow:(NSUInteger)row column:(NSUInteger)column;

/*
 * The selected calyday on calendar view
 */
@property(strong, nonatomic, readwrite) AZCalDay *selectedDay;


/*
    All Calendar GridViews
 */
@property(nonatomic, strong, readwrite) NSArray *visibleGridViews;
@end

@implementation AZCalendarView

@synthesize appear;
@synthesize gridSize = _gridSize;
@synthesize selectedPeriod = _selectedPeriod;
@synthesize calMonth = _calMonth;
@synthesize weekHintView = _weekHintView;
@synthesize selectedDay = _selectedDay;
@synthesize date = _date;
@synthesize minimumDate = _minimumDate;
@synthesize maximumDate = _maximumDate;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize headerView = _headerView;
@synthesize footerView = _footerView;
@synthesize gridScrollView = _gridScrollView;
@synthesize allowsMultipleSelection = _allowsMultipleSelection;

- (void)initParameters {
    _firstLayout = YES;
    _adjustsScrollViewToFitHeight = YES;
    _autoAddNewRowOfCalendar = YES;
    _selectedPeriod = PeriodTypeAllDay;
    _previousSelectedIndex.row = NSNotFound;
    _previousSelectedIndex.column = NSNotFound;
    _gridSize = CGSizeZero;
    _date = [NSDate date];
    _selectedDay = [[AZCalDay alloc] initWithDate:_date];
    _calMonth = [[AZCalMonth alloc] initWithDate:_date];
    _gridViewsArray = [[NSMutableArray alloc] init];
    _monthGridViewsArray = [[NSMutableArray alloc] init];
    _recycledGridSetDic = [[NSMutableDictionary alloc] init];

    NSUInteger days = NUMBER_OF_DAYS_IN_WEEK - 1;
    _selectedIndicesMatrix = (bool **) malloc(sizeof(bool *) * days);
    _focusMatrix = (bool **) malloc(sizeof(bool *) * days);
    for (NSUInteger i = 0 ;i < days ;i++){
        _selectedIndicesMatrix[i] = malloc(sizeof(bool) * NUMBER_OF_DAYS_IN_WEEK);
        memset(_selectedIndicesMatrix[i], NO, NUMBER_OF_DAYS_IN_WEEK);

        _focusMatrix[i] = malloc(sizeof(bool) * NUMBER_OF_DAYS_IN_WEEK);
        memset(_focusMatrix[i], NO, NUMBER_OF_DAYS_IN_WEEK);

    }
    for (NSUInteger index = 0 ;index < days ;index++){
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        [_gridViewsArray addObject:rows];
    }
}

- (void)freeMatrix {
    NSInteger n = 6;
    for (int i = 0 ;i < n ;i++){
        free(_selectedIndicesMatrix[i]);
        _selectedIndicesMatrix[i] = NULL;
        free(_focusMatrix[i]);
        _focusMatrix[i] = NULL;
    }
    free(_selectedIndicesMatrix);
    _selectedIndicesMatrix = NULL;
    free(_focusMatrix);
    _focusMatrix = NULL;

}

- (void)reloadData {
    _firstLayout = YES;
    [self recycleAllGridViews];
    [self setNeedsLayout];
}

- (void)setDate:(NSDate *)date {
    if (_date){
        _date = nil;
    }
    _date = date;
    AZCalMonth *calMonth = [[AZCalMonth alloc] initWithDate:_date];
    self.calMonth = calMonth;
}

- (void)setSelectedDay:(AZCalDay *)selectedDay {
    _selectedDay = selectedDay;
    if (_selectedDay != nil){
        [self calendarGridViewDidChangeDay];
    }
}


- (void)setCalMonth:(AZCalMonth *)calMonth {
    [self recycleAllGridViews];
    if (_calMonth){
        _calMonth = nil;
    }
    _calMonth = calMonth;
    self.selectedDay = [self getFirstSelectedAvailableDay];
    _firstLayout = YES;
    [self setNeedsLayout];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    _minimumDay = [[AZCalDay alloc] initWithDate:_minimumDate];
    _firstLayout = YES;
    [self recycleAllGridViews];
    [self setNeedsLayout];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    if (_maximumDate){
        _maximumDate = nil;
    }
    _maximumDate = maximumDate;
    if (_maximumDay){
        _maximumDay = nil;
    }
    _maximumDay = [[AZCalDay alloc] initWithDate:_maximumDate];

    _firstLayout = YES;
    [self recycleAllGridViews];
    [self setNeedsLayout];
}

- (NSUInteger)getRows {
    NSUInteger offsetRow = [[_calMonth firstDay] getWeekDay] - 1;
    NSUInteger row = (offsetRow + _calMonth.days - 1) / NUMBER_OF_DAYS_IN_WEEK;
    return row + 1;
}

- (NSUInteger)getMonthDayAtRow:(NSUInteger)row column:(NSUInteger)column {
    NSUInteger offsetRow = [[_calMonth firstDay] getWeekDay] - 1;
    NSUInteger day = (row * NUMBER_OF_DAYS_IN_WEEK + 1 - offsetRow) + column;
    return day;
}

- (AZCalDay *)calDayAtGridIndex:(GridIndex)gridIndex {
    NSUInteger day = [self getMonthDayAtRow:(NSUInteger) gridIndex.row column:(NSUInteger) gridIndex.column];
    AZCalDay *calDay = [_calMonth calDayAtDay:day];
    return calDay;
}

- (BOOL)isValidGridViewIndex:(GridIndex)index {
    BOOL valid = YES;
    if (index.column < 0 ||
        index.row < 0 ||
        index.column >= NUMBER_OF_DAYS_IN_WEEK ||
        index.row >= [self getRows]){
        valid = NO;
    }
    return valid;
}

- (CGSize)gridSize {
    // CGSzize != CGSizeZero
    if (_gridSize.width != 0 && _gridSize.height != 0){
        return _gridSize;
    }

    // get from delegate's gridView xib
    GridIndex indexZero;
    indexZero.column = 1;
    indexZero.row = 1;
    AZCalendarGridView *gridView = [self findGridViewAtRow:indexZero.row column:indexZero.column calDay:[self calDayAtGridIndex:indexZero]];
    if (gridView != nil){
        _gridSize = gridView.frame.size;
    }
    return _gridSize;
}


- (CGFloat)widthForGridView {
    CGFloat totalWidth = self.bounds.size.width;
    CGFloat width;
    if (self.decideGridWidthAccordingToXib){
        width = self.gridSize.width;
    } else {
        width = totalWidth / NUMBER_OF_DAYS_IN_WEEK;
    }
    return width;
}

- (GridIndex)getGridViewIndex:(AZCalendarScrollView *)calendarScrollView touches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:calendarScrollView];
    GridIndex index;
    NSInteger row = (location.y - MARGIN_TOP + PADDING_VERTICAL) / (PADDING_VERTICAL + self.gridSize.height);
    CGFloat width = [self widthForGridView];
    NSInteger column = (location.x - MARGIN_LEFT + PADDING_HORIZONTAL) / (PADDING_HORIZONTAL + width);
    index.row = row;
    index.column = column;
    return index;
}

- (GridIndex)gridIndexForGridView:(AZCalendarGridView *)gridView {
    GridIndex index = {NSNotFound, NSNotFound};
    for (NSInteger i = 0 ;i < [_gridViewsArray count] ;i++){
        NSArray *rowGridViewsArray = [_gridViewsArray objectAtIndex:i];
        NSUInteger indexOfGridView = [rowGridViewsArray indexOfObject:gridView];
        if (indexOfGridView != NSNotFound){
            index.row = i;
            index.column = indexOfGridView;
            return index;
        }
    }
    return index;
}

- (NSArray *)visibleGridViews {
    NSMutableArray *gridViewsArray = [NSMutableArray array];// one dimensional array
    for (NSMutableArray *rowGridViewsArray in _gridViewsArray){
        for (AZCalendarGridView *gridView in rowGridViewsArray){
            [gridViewsArray addObject:gridView];
        }
    }
    return gridViewsArray;
}

- (NSString *)findMonthDescription {
    NSString *title = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(calendarView:titleForMonth:)]){
        title = [_dataSource calendarView:self titleForMonth:_calMonth];
    }
    if (!title || ![title length]){
        title = [NSString stringWithFormat:@"%d年%d月", [_calMonth getYear], [_calMonth getMonth]];
    }
    return title;
}

- (NSArray *)findWeekTitles {
    NSArray *titles = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(weekTitlesForCalendarView:)]){
        titles = [_dataSource weekTitlesForCalendarView:self];
        NSAssert([titles count] == NUMBER_OF_DAYS_IN_WEEK, @"Count of WeekHintTitles is `NUMBER_OF_DAYS_IN_WEEK`");
    }
    if (!titles || ![titles count]){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setCalendar:[NSCalendar currentCalendar]];
        [formatter setLocale:[NSLocale currentLocale]];
        NSArray *daySymbols = [formatter shortWeekdaySymbols];
        titles = daySymbols;
    }
    return titles;
}

- (void)recycleAllGridViews {
    /*
     * recycled all grid views
     */
    NSMutableSet *recycledGridSet;
    for (NSMutableArray *rowGridViewsArray in _gridViewsArray){
        for (AZCalendarGridView *gridView in rowGridViewsArray){
            recycledGridSet = [_recycledGridSetDic objectForKey:gridView.identifier];
            if (!recycledGridSet){
                recycledGridSet = [[NSMutableSet alloc] init];
                [_recycledGridSetDic setObject:recycledGridSet forKey:gridView.identifier];
            }
            gridView.selected = NO;
            [gridView removeFromSuperview];
            [recycledGridSet addObject:gridView];
        }
        [rowGridViewsArray removeAllObjects];
    }
    [_monthGridViewsArray removeAllObjects];
}

- (AZCalendarGridView *)getGridViewAtRow:(NSUInteger)row column:(NSUInteger)column {
    AZCalendarGridView *gridView = nil;
    NSMutableArray *rowGridViewsArray = [_gridViewsArray objectAtIndex:row];
    gridView = [rowGridViewsArray objectAtIndex:column];
    return gridView;
}

- (BOOL)isGridViewSelectedEnableAtRow:(NSUInteger)row column:(NSUInteger)column {
    BOOL selectedEnable = YES;
    NSUInteger day = [self getMonthDayAtRow:row column:column];
    if (day < 1 || day > _calMonth.days){
        selectedEnable = NO;
    } else {
        AZCalDay *calDay = [_calMonth calDayAtDay:day];
        if ([self isEarlierMinimumDay:calDay] || [self isAfterMaximumDay:calDay]){
            selectedEnable = NO;
        }
    }
    return selectedEnable;
}

- (void)resetSelectedIndicesMatrix {
    NSInteger n = NUMBER_OF_DAYS_IN_WEEK - 1;
    for (NSInteger row = 0 ;row < n ;row++){
        memset(_selectedIndicesMatrix[row], NO, NUMBER_OF_DAYS_IN_WEEK);
        memset(_focusMatrix[row], NO, NUMBER_OF_DAYS_IN_WEEK);
    }
}

- (void)resetFocusMatrix {
    NSInteger n = NUMBER_OF_DAYS_IN_WEEK - 1;
    for (NSInteger row = 0 ;row < n ;row++){
        memset(_focusMatrix[row], NO, NUMBER_OF_DAYS_IN_WEEK);
    }
}

/*
 * update grid state
 */
- (void)updateSelectedGridViewState {
    AZCalendarGridView *gridView = nil;
    NSInteger rows = [self getRows];
    for (NSInteger row = 0 ;row < rows ;row++){
        for (NSInteger column = 0 ;column < NUMBER_OF_DAYS_IN_WEEK ;column++){
            gridView = [self getGridViewAtRow:row column:column];
            /*
             * grid selected status and current selected status are different
             */
            if (gridView.selected ^ _selectedIndicesMatrix[row][column]){
                gridView.selected = _selectedIndicesMatrix[row][column];
            }
        }
    }
}

- (BOOL)isEarlierMinimumDay:(AZCalDay *)calDay {
    BOOL early = NO;
    if (self.minimumDate != nil){
        if (NSOrderedAscending == [calDay compare:_minimumDay]){
            early = YES;
        }
    }
    return early;
}

- (BOOL)isAfterMaximumDay:(AZCalDay *)calDay {
    BOOL after = NO;
    if (_maximumDate){
        if (NSOrderedDescending == [calDay compare:_maximumDay]){
            after = YES;
        }
    }
    return after;

}

- (void)removeGridViewAtRow:(NSUInteger)row column:(NSUInteger)column {
    NSMutableArray *rowGridViewsArray = [_gridViewsArray objectAtIndex:row];
    if (column < [rowGridViewsArray count]){
        [rowGridViewsArray removeObjectAtIndex:column];
    }
}

- (void)addGridViewAtRow:(AZCalendarGridView *)gridView row:(NSUInteger)row
        column:(NSUInteger)column {
    NSMutableArray *rowGridViewsArray = [_gridViewsArray objectAtIndex:row];
    NSInteger count = [rowGridViewsArray count];
    if (column > count || column < count){
        if (column > count){
            NSInteger offsetCount = column - count + 1;
            for (NSInteger offset = 0 ;offset < offsetCount ;offset++){
                [rowGridViewsArray addObject:[NSNull null]];
            }
        }
        [rowGridViewsArray replaceObjectAtIndex:column withObject:gridView];
    }
    else if (column == count){
        [rowGridViewsArray insertObject:gridView atIndex:column];
    }
}

- (void)layoutGridCells {
    BOOL hasSelectedDay = NO;
    NSInteger count;
    NSInteger row = 0;
    NSInteger column = 0;
    CGFloat maxHeight = 0;
    CGFloat maxWidth = 0;
    CGRect frame;
    AZCalDay *calDay;
    AZCalendarGridView *gridView = nil;

    // Call DataSource delegate

    [self gridViewWillLayout];

    /*
     * layout grid view before selected month on calendar view
     */
    calDay = [_calMonth firstDay];
    if ([calDay getWeekDay] > 1){
        count = [calDay getWeekDay] - 1;
        AZCalMonth *previousMonth = [_calMonth previousMonth];
        row = 0;
        for (NSInteger day = previousMonth.days ;count > 0 && day >= 1 ;day--){
            calDay = [previousMonth calDayAtDay:day];
            column = [calDay getWeekDay] - 1;
            gridView = [self findDisableGridViewAtRow:row column:column calDay:calDay];
            if (gridView == nil){
                count--;
                continue;
            }
            gridView.delegate = self;
            gridView.calDay = calDay;
            gridView.row = row;
            gridView.column = column;
            frame = [self getFrameForRow:row column:column];
            gridView.frame = frame;
            [gridView setNeedsLayout];
            [self.gridScrollView addSubview:gridView];
            [self addGridViewAtRow:gridView row:row column:column];
            count--;
        }
    }
    NSUInteger offsetRow = [[_calMonth firstDay] getWeekDay] - 1;
    for (NSInteger day = 1 ;day <= _calMonth.days ;day++){
        calDay = [_calMonth calDayAtDay:day];
        row = (offsetRow + day - 1) / NUMBER_OF_DAYS_IN_WEEK;
        column = [calDay getWeekDay] - 1;
        gridView = [self findGridViewAtRow:row column:column calDay:calDay];
        if (gridView == nil){
            continue;
        }
        gridView.delegate = self;
        gridView.calDay = calDay;
        gridView.row = row;
        gridView.column = column;
        gridView.canSelect = ([self isEarlierMinimumDay:calDay] || [self isAfterMaximumDay:calDay]) ? NO : YES;
        if ([calDay isEqualToDay:self.selectedDay]){
            hasSelectedDay = YES;
            gridView.selected = YES;
            _selectedIndicesMatrix[row][column] = YES;
        }
        frame = [self getFrameForRow:row column:column];
        gridView.frame = frame;
        [gridView setNeedsLayout];
        [self.gridScrollView addSubview:gridView];
        [_monthGridViewsArray addObject:gridView];
        [self addGridViewAtRow:gridView row:row column:column];

    }
    if (!hasSelectedDay && [_monthGridViewsArray count] > 0){
        AZCalendarGridView *selectedGridView = [_monthGridViewsArray objectAtIndex:0];
        _selectedIndicesMatrix[selectedGridView.row][selectedGridView.column] = YES;
        selectedGridView.selected = YES;
    }
    /*
     * layout grid view after selected month on calendar view
     */
    calDay = [_calMonth lastDay];
    if ([calDay getWeekDay] < NUMBER_OF_DAYS_IN_WEEK){
        NSUInteger days = NUMBER_OF_DAYS_IN_WEEK - [calDay getWeekDay];
        AZCalMonth *nextMonth = [_calMonth nextMonth];
        for (NSInteger day = 1 ;day <= days ;day++){
            calDay = [nextMonth calDayAtDay:day];
            column = [calDay getWeekDay] - 1;
            gridView = [self findDisableGridViewAtRow:row column:column calDay:calDay];
            if (gridView == nil){
                continue;
            }
            gridView.delegate = self;
            gridView.calDay = calDay;
            gridView.row = row;
            gridView.column = column;
            frame = [self getFrameForRow:row column:column];
            gridView.frame = frame;
            [gridView setNeedsLayout];
            [self.gridScrollView addSubview:gridView];
            [self addGridViewAtRow:gridView row:row column:column];
        }
    }
    // always five rows
    // TODO : more more smart code...
    if (self.autoAddNewRowOfCalendar && row < 5){
        NSInteger currentLow = row + 1;
        NSInteger needLoopCount = 5 - row;// 1,2...
        AZCalMonth *nextMonth = [_calMonth nextMonth];
        NSInteger offsetLastRow = [[nextMonth firstDay] getWeekDay] - 1;
        NSInteger thisRowStartDay = (offsetLastRow == 0) ? 0 : NUMBER_OF_DAYS_IN_WEEK - offsetLastRow;
        // Add last row
        // add 7 , add 14
        for (NSInteger day = 1 ;day <= (NUMBER_OF_DAYS_IN_WEEK * needLoopCount) ;day++){
            NSInteger offsetDay = day - 1;
            // avoid zero division
            if (offsetDay == 0){
                row = currentLow;
            } else {
                row = currentLow + (offsetDay / NUMBER_OF_DAYS_IN_WEEK);
            }
            calDay = [nextMonth calDayAtDay:day + thisRowStartDay];

            column = [calDay getWeekDay] - 1;
            gridView = [self findDisableGridViewAtRow:row column:column calDay:calDay];
            if (gridView == nil){
                continue;
            }
            gridView.delegate = self;
            gridView.calDay = calDay;
            gridView.row = row;
            gridView.column = column;
            frame = [self getFrameForRow:row column:column];
            gridView.frame = frame;
            [gridView setNeedsLayout];
            [self.gridScrollView addSubview:gridView];
            [self addGridViewAtRow:gridView row:row column:column];
        }
    }
    // get last row
    AZCalendarGridView *lastGridView = [[_gridViewsArray lastObject] lastObject];
    if (CGRectGetMaxX(lastGridView.frame) > maxWidth){
        maxWidth = CGRectGetMaxX(lastGridView.frame);
    }
    if (CGRectGetMaxY(lastGridView.frame) > maxHeight){
        maxHeight = CGRectGetMaxY(lastGridView.frame);
    }
    self.gridScrollView.contentSize = CGSizeMake(maxWidth, maxHeight);
    // Call DataSource delegate
    [self gridViewDidLayout];
}

- (CGRect)getFrameForRow:(NSUInteger)row column:(NSUInteger)column {
    int calcRow = row;
    int calcColumn = column;

    CGFloat width = [self widthForGridView];
    CGFloat x = width * calcColumn;
    //  MARGIN_LEFT + padding * PADDING_HORIZONTAL + calcColumn * self.gridSize.width
    CGFloat y = MARGIN_TOP + calcRow * self.gridSize.height;
    CGRect frame = CGRectMake(x, y, self.gridSize.width, self.gridSize.height);
    return frame;
}

- (AZCalDay *)getFirstSelectedAvailableDay {
    AZCalDay *selectedCalDay = nil;
    for (NSInteger day = 1 ;day <= _calMonth.days ;day++){
        AZCalDay *calDay = [_calMonth calDayAtDay:day];
        if ([calDay isToday]){
            selectedCalDay = calDay;
            break;
        }
    }
    if (!selectedCalDay){
        selectedCalDay = [_calMonth firstDay];
    }
    return selectedCalDay;
}

#pragma mark - dataSource delegate
- (void)gridViewWillLayout {
    if (_dataSource && [_dataSource respondsToSelector:@selector(gridViewWillLayout:month:)]){
        [_dataSource gridViewWillLayout:self month:_calMonth];
    }
}

- (void)gridViewDidLayout {
    if (_dataSource && [_dataSource respondsToSelector:@selector(gridViewDidLayout:month:)]){
        [_dataSource gridViewDidLayout:self month:_calMonth];
    }
}

- (AZCalendarViewHeaderView *)findHeaderView {
    AZCalendarViewHeaderView *headerView = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(headerViewForCalendarView:)]){
        headerView = [_dataSource headerViewForCalendarView:self];
    }
    return headerView;
}

- (AZCalendarWeekHintView *)findWeekHintView {
    AZCalendarWeekHintView *weekHintView = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(weekHintViewForCalendarView:)]){
        weekHintView = [_dataSource weekHintViewForCalendarView:self];
    }
    return weekHintView;
}

- (AZCalendarViewFooterView *)findFooterView {
    AZCalendarViewFooterView *footerView = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(footerViewForCalendarView:)]){
        footerView = [_dataSource footerViewForCalendarView:self];
    }
    return footerView;
}

- (AZCalendarGridView *)findGridViewAtRow:(NSUInteger)row
                        column:(NSUInteger)column
                        calDay:(AZCalDay *)calDay {
    AZCalendarGridView *gridView = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(calendarView:calendarGridViewForRow:column:calDay:)]){
        gridView = [_dataSource calendarView:self calendarGridViewForRow:row column:column calDay:calDay];
    }
    return gridView;
}

- (AZCalendarGridView *)findDisableGridViewAtRow:(NSUInteger)row
                        column:(NSUInteger)column
                        calDay:(AZCalDay *)calDay {
    AZCalendarGridView *gridView = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(calendarView:calendarDisableGridViewForRow:column:calDay:)]){
        gridView = [_dataSource calendarView:self calendarDisableGridViewForRow:row column:column calDay:calDay];
    }
    return gridView;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self){
        return nil;
    }

    return self;
}

- (AZCalendarGridView *)dequeueCalendarGridViewWithIdentifier:(NSString *)identifier {
    AZCalendarGridView *gridView = nil;
    NSMutableSet *recycledGridSet = [_recycledGridSetDic objectForKey:identifier];
    if (recycledGridSet){
        gridView = [recycledGridSet anyObject];
        if (gridView){
            [recycledGridSet removeObject:gridView];
        }
    }
    return gridView;
}

- (BOOL)appear {
    return (self.alpha > 0);
}

- (void)animationChangeMonth:(BOOL)next {
    UIViewAnimationOptions options;
    if (next){
        options = UIViewAnimationOptionCurveEaseInOut;
    } else {
        options = UIViewAnimationOptionCurveEaseInOut;
    }
    _calendarHeaderView.nextMonthButton.userInteractionEnabled = NO;
    _calendarHeaderView.previousMonthButton.userInteractionEnabled = NO;
    AZCalMonth *month = nil;
    if (next){
        month = [_calMonth nextMonth];
    } else {
        month = [_calMonth previousMonth];
    }

    // update grid cells
    self.calMonth = month;
    _date = [month firstDay].date;
    [UIImageView transitionWithView:self.gridScrollView duration:0.3 options:options animations:^{
    } completion:^(BOOL finished) {
        if (finished){
            _calendarHeaderView.nextMonthButton.userInteractionEnabled = YES;
            _calendarHeaderView.previousMonthButton.userInteractionEnabled = YES;
        }
    }];
}

- (void)showNextMonth {
    [self resetSelectedIndicesMatrix];
    [self animationChangeMonth:YES];
}

- (void)nextMonth {
    [self showNextMonth];
}


- (void)showPreviousMonth {
    [self resetSelectedIndicesMatrix];
    [self animationChangeMonth:NO];
}

- (void)previousMonth {
    [self showPreviousMonth];
}

- (void)layoutSubviews {

    if (_dataSource && _firstLayout){
        /*
         * layout Calendar Grid Cell
         */
        [self layoutGridCells];
        /*
         * layout week hint labels
         */
        for (UIView *subview in self.weekHintView.subviews){
            if (![subview isKindOfClass:[UIImageView class]]){
                [subview removeFromSuperview];
            }
        }
        CGFloat width = [self widthForGridView];
        CGFloat marginX = 0;
        NSArray *titles = [self findWeekTitles];
        for (NSInteger i = 0 ;i < NUMBER_OF_DAYS_IN_WEEK ;i++){
            // Day's Button Label
            AZCalendarWeekHintView *weekHintView = [self findWeekHintView];
            weekHintView.frame = CGRectMake(marginX, 0, width, CGRectGetHeight(self.weekHintView.bounds));
            [weekHintView setTitle:[titles objectAtIndex:i]];
            enum AZ_DayOfWeek week = (enum AZ_DayOfWeek) i;
            [weekHintView setDayOfWeek:week];// 0,1... == Sun,Mon,....
            [weekHintView setNeedsLayout];
            [self.weekHintView addSubview:weekHintView];
            marginX += width;
        }
        /*
         * layout header view
         */
        if (!_calendarHeaderView){
            AZCalendarViewHeaderView *calendarHeaderView = [self findHeaderView];
            if (calendarHeaderView){
                if (_calendarHeaderView){
                    [_calendarHeaderView removeFromSuperview];
                }
                CGRect frame = calendarHeaderView.bounds;
                frame.origin.x = (CGRectGetWidth(self.headerView.bounds) - CGRectGetWidth(frame)) / 2;
                frame.origin.y = (CGRectGetHeight(self.headerView.bounds) - CGRectGetHeight(frame)) / 2;
                calendarHeaderView.delegate = self;
                calendarHeaderView.frame = frame;
                _calendarHeaderView = calendarHeaderView;
                [self.headerView addSubview:_calendarHeaderView];
            }
        }
        /*
         * layout footer view
         */
        // if do not implement footer view, remove footer view.
        if (!_calendarFooterView){
            AZCalendarViewFooterView *calendarFooterView = [self findFooterView];
            if (calendarFooterView){
                if (_calendarFooterView){
                    [_calendarFooterView removeFromSuperview];
                }
                CGRect frame = calendarFooterView.bounds;
                frame.origin.x = (CGRectGetWidth(self.footerView.bounds) - CGRectGetWidth(frame)) / 2;
                frame.origin.y = (CGRectGetHeight(self.footerView.bounds) - CGRectGetHeight(frame)) / 2;
                calendarFooterView.frame = frame;
                _calendarFooterView = calendarFooterView;
                [self.footerView addSubview:_calendarFooterView];
            } else {
                if ([_footerView isDescendantOfView:self]){
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                        self.frame.size.width, self.frame.size.height - _footerView.frame.size.height);
                    [_footerView removeFromSuperview];
                }
            }
        }

        // auto resize
        if (self.adjustsScrollViewToFitHeight){
            CGFloat heightForCalendarScrollView = [self heightForCalendarScrollView];
            [self.gridScrollView setFrame:CGRectMake(self.gridScrollView.frame.origin.x, self.gridScrollView.frame.origin.y,
                self.gridScrollView.frame.size.width, heightForCalendarScrollView)];
        }

        _firstLayout = NO;
    }
    _calendarHeaderView.title = [self findMonthDescription];
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    if (UISwipeGestureRecognizerDirectionLeft == gesture.direction){
        [self showNextMonth];
    }
    else {
        [self showPreviousMonth];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.alpha = 0.0; // default is hidden Calendar
    self.multipleTouchEnabled = YES;
    self.gridScrollView.calendarScrollViewDelegate = self;
    [self initParameters];
}

- (NSDate *)selectedDate {
    return self.selectedDay.date;
}

- (NSArray *)selectedDateArray {
    if (!_allowsMultipleSelection){
        return nil;
    } else {
        NSUInteger rows = [self getRows];
        NSMutableArray *selectedDates = [NSMutableArray array];
        for (NSUInteger row = 0 ;row < rows ;row++){
            for (NSUInteger column = 0 ;column < NUMBER_OF_DAYS_IN_WEEK ;column++){
                if (_selectedIndicesMatrix[row][column]){
                    NSUInteger day = [self getMonthDayAtRow:row column:column];
                    AZCalDay *calDay = [_calMonth calDayAtDay:day];
                    [selectedDates addObject:calDay.date];
                    AZLog(@"selected day %d", day);
                }
            }
        }
        return selectedDates;
    }
}


- (void)dealloc {
    [self freeMatrix];
    _delegate = nil;
    _calendarHeaderView = nil;
    _recycledGridSetDic = nil;
    _gridViewsArray = nil;
    _monthGridViewsArray = nil;
    _minimumDay = nil;
    _maximumDay = nil;
}
#pragma mark - CalendarViewHeaderViewDelegate
- (void)calendarViewHeaderViewNextMonth:(AZCalendarViewHeaderView *)calendarHeaderView {
    [self showNextMonth];
}

- (void)calendarViewHeaderViewPreviousMonth:(AZCalendarViewHeaderView *)calendarHeaderView {
    [self showPreviousMonth];
}

- (void)calendarViewHeaderViewDidCancel:(AZCalendarViewHeaderView *)calendarHeaderView {
    [self hide];
}

- (void)calendarViewHeaderViewDidSelection:(AZCalendarViewHeaderView *)calendarHeaderView {
    [self hide];
}
#pragma mark - CalendarGridViewDelegate
- (void)calendarGridViewDidChangeDay{
    if (_delegate && [_delegate respondsToSelector:@selector(calendarView:didChangeDate:)]){
        [_delegate calendarView:self didChangeDate:self.selectedDay.date];
    }
    // deprecated delegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (_delegate && [_delegate respondsToSelector:@selector(calendarView:didSelectDay:)]) {
        [_delegate calendarView:self didSelectDay:self.selectedDay];
    }
#pragma clang diagnostic pop
}

- (void)calendarGridViewDidSelectDay:(AZCalDay *) calDay {
    if (_delegate && [_delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [_delegate calendarView:self didSelectDate:calDay.date];
    }
}

- (void)hide:(BOOL)animated {
    [UIView animateWithDuration:0.3 animations:^{
        [self hide];
    }];
}

- (void)hide {
    self.alpha = 0.0;
}

- (void)show:(BOOL)animated {
    [UIView animateWithDuration:0.3 animations:^{
        [self show];
    }];
}

- (void)show {
    self.alpha = 1.0;
    [self setNeedsLayout];
}

- (void)showInView:(UIView *)view {
    if (![self isDescendantOfView:view]){
        [view addSubview:self];
    }
    [self show:YES];
}
#pragma mark - CalendarScrollViewDelegate
- (void)calendarScrollViewTouchesBegan:(AZCalendarScrollView *)calendarScrollView
        touches:(NSSet *)touches
        withEvent:(UIEvent *)event {
    _moved = NO;
    UITouch *beginTouch = [touches anyObject];
    _beginTimeInterval = beginTouch.timestamp;
    _beginPoint = [beginTouch locationInView:calendarScrollView];
}

- (void)calendarScrollViewTouchesMoved:(AZCalendarScrollView *)calendarScrollView
        touches:(NSSet *)touches
        withEvent:(UIEvent *)event {
    _moved = YES;
    GridIndex index = [self getGridViewIndex:calendarScrollView touches:touches];
    if ([self isValidGridViewIndex:index]){
        if (_allowsMultipleSelection){
            BOOL selectedEnable = NO;
            /*
             * the grid is on unselected state
             */
            if (!_selectedIndicesMatrix[index.row][index.column]){
                [self resetFocusMatrix];
                _focusMatrix[index.row][index.column] = YES;
                selectedEnable = !_selectedIndicesMatrix[index.row][index.column];
                selectedEnable = (selectedEnable & [self isGridViewSelectedEnableAtRow:index.row column:index.column]);
                _selectedIndicesMatrix[index.row][index.column] = selectedEnable;
            }
        }
        else {
            //do nothing
        }
        _previousSelectedIndex = index;
        [self updateSelectedGridViewState];
    }
}

- (void)calendarScrollViewTouchesEnded:(AZCalendarScrollView *)calendarScrollView
        touches:(NSSet *)touches
        withEvent:(UIEvent *)event {
    GridIndex index = [self getGridViewIndex:calendarScrollView touches:touches];
    if ([self isValidGridViewIndex:index]){
        BOOL selectedEnable = YES;
        NSUInteger row = (NSUInteger) index.row;
        NSUInteger column = (NSUInteger) index.column;
        if (!_moved){
            if (!_allowsMultipleSelection){
                [self resetSelectedIndicesMatrix];
                selectedEnable = YES;
                selectedEnable = selectedEnable & [self isGridViewSelectedEnableAtRow:row column:column];
                _selectedIndicesMatrix[row][column] = selectedEnable;
            }
            else {
                selectedEnable = _selectedIndicesMatrix[row][column];
                _selectedIndicesMatrix[row][column] = !selectedEnable;
            }
        }
        // update state
        [self updateSelectedGridViewState];
        if (!_allowsMultipleSelection){
            if (!_moved){
                NSInteger day = [self getMonthDayAtRow:row column:column];
                if (day >= 1 && day <= _calMonth.days){
                    AZCalDay *calDay = [_calMonth calDayAtDay:day];
                    self.selectedDay = calDay;
                    [self calendarGridViewDidSelectDay:calDay];
                }
            }
        }
    }
    UITouch *endTouch = [touches anyObject];
    if (self.swipeTimeInterval == 0){
        self.swipeTimeInterval = SWIPE_TIMER_INTERVAL;
    }
    if (endTouch.timestamp - _beginTimeInterval <= self.swipeTimeInterval){
        CGPoint endPoint = [endTouch locationInView:calendarScrollView];
        if (fabs(endPoint.y - _beginPoint.y) < HORIZONTAL_SWIPE_HEIGHT_CONSTRAINT){
            if (fabs(endPoint.x - _beginPoint.x) > HORIZONTAL_SWIPE_WIDTH_CONSTRAINT){
                //swipe right
                if (endPoint.x > _beginPoint.x){
                    [self showPreviousMonth];
                }
                else {
                    [self showNextMonth];
                }
            }
        }
    }
}

- (CGFloat)heightForCalendarScrollView {
    CGFloat scrollViewHeight = 0.0f;
    BOOL horizontalIndicator = self.gridScrollView.showsHorizontalScrollIndicator;
    self.gridScrollView.showsHorizontalScrollIndicator = NO;
    BOOL verticalIndicator = self.gridScrollView.showsVerticalScrollIndicator;
    self.gridScrollView.showsVerticalScrollIndicator = NO;
    for (UIView *view in self.gridScrollView.subviews){
        if (!view.hidden){
            CGFloat currentY = view.frame.origin.y;
            CGFloat currentHeight = view.frame.size.height;
            if (currentY + currentHeight > scrollViewHeight){
                scrollViewHeight = currentHeight + currentY;
            }
        }
    }
    self.gridScrollView.showsHorizontalScrollIndicator = horizontalIndicator;
    self.gridScrollView.showsVerticalScrollIndicator = verticalIndicator;

    return scrollViewHeight;
}

+ (id)viewFromNib {
    Class selfClass = [self class];
    return [[[NSBundle bundleForClass:selfClass] loadNibNamed:NSStringFromClass(selfClass) owner:self options:nil]
                       objectAtIndex:0];
}

@end
