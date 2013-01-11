//
//  Created by azu on 13/01/11.
//


#import "AZCalendarBaseView.h"
#import "CalendarView.h"
#import "BaseDataSourceImp.h"


@implementation AZCalendarBaseView {

}

- (void)awakeFromNib {
    [super awakeFromNib];

    BaseDataSourceImp *dataSource = [[BaseDataSourceImp alloc] init];
    self.calendarView = [CalendarView viewFromNib];
    self.calendarView.frame = CGRectMake(0, 0, 320, self.calendarView.frame.size.height);
    self.calendarView.gridSize = CGSizeMake(45.5, 35);
    self.calendarView.dataSource = dataSource;
    [self.calendarView showInView:self];// or [self.view addSubView:self.calendarView];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.calendarView.frame = CGRectMake(0, 0, 320, self.calendarView.frame.size.height);
}

@end