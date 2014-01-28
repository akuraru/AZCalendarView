//
//  FirstViewController.m
//  AZCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

#import "FirstViewController.h"
#import "AZCalendarView.h"
#import "CalendarPlaceholderView.h"
#import "BaseCalendarDisableGridView.h"
#import "BaseDataSourceImp.h"
#import "BaseCalendarView.h"

@interface FirstViewController ()

@property(nonatomic, strong) BaseDataSourceImp *dataSource;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup dataSource
    self.dataSource = [[BaseDataSourceImp alloc] init];
    self.calendarView = self.calendarBaseView.calendarView;
    self.calendarView.dataSource = self.dataSource;
    self.calendarView.delegate = self;
    [self.calendarView show];
}


// without reloadData - update "only" GridView , faster than reloadData.
- (void)updateCalendarView {
    NSArray *visibleGridViews = [self.calendarView visibleGridViews];
    for (AZCalendarGridView *gridView in visibleGridViews) {
        if ([gridView isKindOfClass:[BaseCalendarDisableGridView class]]) {
            continue;// disable cells is not update
        }
        GridIndex gridIndex = [self.calendarView gridIndexForGridView:gridView];
        AZCalDay *calDay = [self.calendarView calDayAtGridIndex:gridIndex];
        [self.dataSource updateGridView:gridView calendarGridViewForRow:gridIndex.row column:gridIndex.column calDay:calDay];
    }
}
#pragma mark - calendar delegate
- (void)calendarView:(AZCalendarView *) calendarView didChangeDate:(NSDate *) date {
    NSLog(@"change date = %@", date);
}

- (void)calendarView:(AZCalendarView *) calendarView didSelectDate:(NSDate *) date {
    NSLog(@"select date = %@", date);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];

    // when Navigation back etc..
    [self updateCalendarView];
    // or use [self.calendarView reloadData];
}

- (void)viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
}

@end
