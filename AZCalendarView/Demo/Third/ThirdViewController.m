//
//  ThirdViewController.m
//  AZCalendarView
//
//  Created by azu on 01/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"
#import "AZCalendarGridView.h"
#import "BaseDataSourceImp.h"
#import "ThirdCalendarView.h"
#import "AZCalendarView.h"
#import "BaseCalendarDisableGridView.h"
#import "ThirdDataSourceImp.h"
#import "BaseCalendarView.h"
#import "ThirdCalendarView.h"
#import "ThirdDataSourceImp.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        self.dataSource = [[ThirdDataSourceImp alloc] init];
        self.calendarView = [ThirdCalendarView viewFromNib];
        self.calendarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.calendarView.frame.size.height);
        self.calendarView.dataSource = self.dataSource;
        self.calendarView.delegate = self;
        [self.view addSubview:self.calendarView];
    }

    [self updateNavigationTitleDate:self.calendarView.date];
    [self.calendarView show];
}

- (void)calendarView:(AZCalendarView *)calendarView didSelectDay:(AZCalDay *)calDay {
    NSLog(@"Selected Date = %@", calDay.date);

    [self updateNavigationTitleDate:calDay.date];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateCalendarNavigationButtons];
}

- (void)updateNavigationTitleDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"YM" options:0 locale:[NSLocale currentLocale]]];
    self.navigationItem.title = [formatter stringFromDate:date];
}

- (void)updateCalendarNavigationButtons {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(prevCalendar)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextCalendar)];
    UIBarButtonItem *today = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(todayCalendar)];
    self.navigationItem.leftBarButtonItems = @[left, right, today];
}

- (void)todayCalendar {
    [self.calendarView setDate:[NSDate date]];
}

- (void)nextCalendar {
    [self.calendarView showNextMonth];
}

- (void)prevCalendar {
    [self.calendarView showPreviousMonth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
