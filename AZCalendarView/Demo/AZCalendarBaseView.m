//
//  Created by azu on 13/01/11.
//


#import "AZCalendarBaseView.h"
#import "CalendarView.h"
#import "BaseDataSourceImp.h"
#import "BaseCalendarView.h"


@implementation AZCalendarBaseView {

}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.calendarView = [BaseCalendarView viewFromNib];
    self.calendarView.frame = CGRectMake(0, 0, 320, self.calendarView.frame.size.height);
    self.calendarView.adjustsScrollViewToFitHeight = NO;// doesn't resize scrollVIew
    self.calendarView.alwaysSameHeight = NO;// doesn't resize scrollVIew

    [self.calendarView showInView:self];// or [self.view addSubView:self.calendarView];
    NSLog(@"%s", sel_getName(_cmd));

}


- (void)layoutSubviews {
    [super layoutSubviews];
}


@end