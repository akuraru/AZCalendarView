//
//  SecondViewController.h
//
//  Created by azu on 12/12/14.
//

// CodeBase of AZCalendarView
#import <UIKit/UIKit.h>
#import "CalendarViewDelegate.h"

@class CalendarView;

@interface SecondViewController : UIViewController <CalendarViewDelegate>

@property(nonatomic, strong) CalendarView *calendarView;
@end
