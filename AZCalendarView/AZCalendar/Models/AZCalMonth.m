//
// Created by azu on 2013/03/28.
//


#import "AZCalMonth.h"
#import "AZCalDay.h"
#import "AZDateUtil.h"


@interface AZCalMonth ()
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSDateComponents *components;
@property(nonatomic) NSInteger numberOfDays;
@property(nonatomic) NSInteger year;
@property(nonatomic) NSInteger month;
@property(nonatomic, strong) NSMutableArray *daysOfMonth;
@end

@implementation AZCalMonth
// lump make AZCalDay
- (void)lumpAZDayOfMonth {
    self.numberOfDays = [AZDateUtil numberOfDaysInMonthDate:self.date];
    self.year = [self.components year];
    self.month = [self.components month];
    self.daysOfMonth = [NSMutableArray array];
    // 1...day of month
    for (NSInteger day = 1; day <= self.numberOfDays; day++) {
        AZCalDay *calDay = [[AZCalDay alloc] initWithYear:self.year month:self.month day:day];
        [self.daysOfMonth addObject:calDay];
    }
}

- (id)initWithDate:(NSDate *) date {
    self = [self init];
    if (self == nil) {
        return nil;
    }
    _date = date;

    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    self.components = components;

    [self lumpAZDayOfMonth];
    return self;
}

- (id)initWithMonth:(NSUInteger) month year:(NSUInteger) year day:(NSUInteger) day {
    self = [self init];
    if (self == nil) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    _components = [[NSDateComponents alloc] init];
    [_components setYear:year];
    [_components setMonth:month];
    [_components setDay:day];
    _date = [calendar dateFromComponents:self.components];

    [self lumpAZDayOfMonth];
    return self;
}

- (AZCalDay *)calDayAtDay:(NSUInteger) day {
    NSUInteger indexOfDay = day - 1;
    return self.daysOfMonth[indexOfDay];
}

- (AZCalDay *)firstDay {
    return self.daysOfMonth[0];
}

- (AZCalDay *)lastDay {
    NSUInteger lastIndex = (NSUInteger)(self.numberOfDays - 1);
    return self.daysOfMonth[lastIndex];
}

- (NSUInteger)getYear {
    return (NSUInteger)self.year;
}

- (NSUInteger)getMonth {
    return (NSUInteger)self.month;
}

- (AZCalMonth *)nextMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nextMonthDate = [calendar dateByAddingComponents:dateComponents toDate:self.date options:0];
    return [[AZCalMonth alloc] initWithDate:nextMonthDate];
}

- (AZCalMonth *)previousMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nextMonthDate = [calendar dateByAddingComponents:dateComponents toDate:self.date options:0];
    return [[AZCalMonth alloc] initWithDate:nextMonthDate];
}

- (NSUInteger)days {
    return (NSUInteger)self.numberOfDays;
}

@end