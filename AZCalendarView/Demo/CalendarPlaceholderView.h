//
//  Created by azu on 13/01/11.
//


#import <Foundation/Foundation.h>
#import "AZCalendarViewDelegate.h"

@class BaseCalendarView;


@interface CalendarPlaceholderView : UIView <AZCalendarViewDelegate>

@property(nonatomic, strong) BaseCalendarView *calendarView;

@end