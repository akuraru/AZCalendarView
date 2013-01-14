//
//  FirstViewController.h
//  AZCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

// UIView Subclass implement of AZCalendarView

#import <UIKit/UIKit.h>
#import "AZCalendarViewDelegate.h"

@class AZCalendarView;
@class CalendarPlaceholderView;
@class BaseCalendarView;
@class BaseDataSourceImp;

@interface FirstViewController : UIViewController <AZCalendarViewDelegate>

@property(weak, nonatomic) IBOutlet CalendarPlaceholderView *calendarBaseView;
@property(nonatomic, strong) BaseCalendarView *calendarView;
@end
