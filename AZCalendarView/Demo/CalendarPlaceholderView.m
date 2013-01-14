//
//  Created by azu on 13/01/11.
//


#import "CalendarPlaceholderView.h"
#import "AZCalendarView.h"
#import "BaseCalendarView.h"


@implementation CalendarPlaceholderView {

}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.calendarView = [BaseCalendarView viewFromNib];
    self.calendarView.frame = CGRectMake(0, 0, self.bounds.size.width, self.calendarView.frame.size.height);
    self.calendarView.adjustsScrollViewToFitHeight = NO;// doesn't resize scrollVIew
    self.calendarView.autoAddNewRowOfCalendar = NO;// doesn't resize scrollVIew
    [self addSubview:self.calendarView];

}


- (void)layoutSubviews {
    [super layoutSubviews];
}


@end