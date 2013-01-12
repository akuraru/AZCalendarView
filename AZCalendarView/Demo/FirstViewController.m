//
//  FirstViewController.m
//  AZCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

#import "FirstViewController.h"
#import "CalendarView.h"
#import "AZCalendarBaseView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.calendarView = self.calendarBaseView.calendarView;
    self.calendarView.delegate = self;
}

- (void)calendarView:(CalendarView *)calendarView didSelectDay:(CalDay *)calDay {
    NSLog(@"Selected Date = %@", calDay);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 更新し直す
    [self.calendarView updateCalendar];
}

@end
