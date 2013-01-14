//
//  SecondViewController.h
//
//  Created by azu on 12/12/14.
//

// CodeBase of AZCalendarView
#import <UIKit/UIKit.h>
#import "AZCalendarViewDelegate.h"

@class BaseDataSourceImp;
@class BaseCalendarView;

@interface SecondViewController : UIViewController <AZCalendarViewDelegate>

@property(nonatomic, strong) BaseCalendarView *calendarView;
@end
