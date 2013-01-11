//
//  SecondViewController.m
//  ZHJCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

#import "SecondViewController.h"
#import "BaseDataSourceImp.h"
#import "CalendarView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadView {
    [super loadView];
    // load CalendarView
    [self loadCalendarView];
}

- (void)loadCalendarView {
    if (self.calendarView == nil){
        BaseDataSourceImp *dataSource = [[BaseDataSourceImp alloc] init];
        self.calendarView = [CalendarView viewFromNib];
        self.calendarView.frame = CGRectMake(0, 0, 320, self.calendarView.frame.size.height);
        self.calendarView.gridSize = CGSizeMake(45.5, 35);
        self.calendarView.dataSource = dataSource;
        self.calendarView.delegate = self;
        [self.view addSubview:self.calendarView];
    }
    [self.calendarView show];
}

- (void)calendarViewDidSelectDay:(CalendarView *)calendarView calDay:(CalDay *)calDay {
    NSLog(@"Selected Date = %@", calDay.date);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Update Calendar
    [self.calendarView updateCalendar];
}

@end
