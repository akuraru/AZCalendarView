//
//  FirstViewController.h
//  ZHJCalendar-sample
//
//  Created by azu on 12/12/14.
//  Copyright (c) 2012年 plusr. All rights reserved.
//

// UIView Subclass implement of AZCalendarView

#import <UIKit/UIKit.h>
#import "CalendarViewDelegate.h"

@class CalendarView;
@class AZCalendarBaseView;

@interface FirstViewController : UIViewController <CalendarViewDelegate>

@property (weak, nonatomic) IBOutlet AZCalendarBaseView *calendarBaseView;
@property (nonatomic,strong)CalendarView *calendarView;
@end
