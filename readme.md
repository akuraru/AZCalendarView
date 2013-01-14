# AZCalendarView

Calendar library has similar delegate methods to a `UITableView` .

![calendar](http://monosnap.com/image/AXX2qrYVUnYppCHxRshyehlre)

# Breakdown

* support iPhone and iPad
* It has similar delegate methods to a `UITableViewDataSource`
* allow `allowsMultipleSelection`
* doesn't support landscape yet...

# Usage


``` objc
BaseDataSourceImp *dataSource = [[BaseDataSourceImp alloc] init];
BaseCalendarView *calendarView = [BaseCalendarView viewFromNib];// don't use alloc init...
calendarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.calendarView.frame.size.height);
calendarView.dataSource = dataSource;
calendarView.delegate = self;// <AZCalendarViewDelegate>
[self.view addSubview:calendarView];
```

* BaseDataSourceImp is implemented of `<AZCalendarViewDataSource>` .


See AZUCalendar/DEMO for details.

# Acknowledgment

These source codes base on [heavensword / CalendarView](https://github.com/heavensword/CalendarView "heavensword / CalendarView").
