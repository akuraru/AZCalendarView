//
//  Created by azu on 13/01/11.
//


#import <Foundation/Foundation.h>
#import "CalendarViewDelegate.h"

@class BaseCalendarView;


@interface CalendarPlaceholderView : UIView <CalendarViewDelegate>

@property(nonatomic, strong) BaseCalendarView *calendarView;
@end