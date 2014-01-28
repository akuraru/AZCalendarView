//
//  SecondViewController.m
//  AZCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

#import "SecondViewController.h"
#import "BaseDataSourceImp.h"
#import "AZCalendarView.h"
#import "BaseCalendarDisableGridView.h"
#import "BaseCalendarView.h"

@interface SecondViewController ()

@property(nonatomic, strong) BaseDataSourceImp *dataSource;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadView {
    [super loadView];
    // load AZCalendarView
    [self loadCalendarView];
}

// without reloadData
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

- (void)loadCalendarView {
    if (self.calendarView == nil) {
        self.dataSource = [[BaseDataSourceImp alloc] init];
        self.calendarView = [BaseCalendarView viewFromNib];
        self.calendarView.frame = CGRectMake(0, 80, self.view.bounds.size.width,
            self.calendarView.frame.size.height);
        self.calendarView.dataSource = self.dataSource;
        self.calendarView.delegate = self;
        [self.view addSubview:self.calendarView];
    }
    [self.calendarView show];
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
    // Update Calendar
    [self updateCalendarView];
}

@end
