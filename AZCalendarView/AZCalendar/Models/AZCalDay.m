//
// Created by azu on 2013/03/28.
//


#import "AZCalDay.h"

@interface AZCalDay ()

@property(nonatomic, strong, readwrite) NSDate *date;

@end

@implementation AZCalDay

- (id)initWithDate:(NSDate *) date {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _date = date;

    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    _components = components;

    return self;
}

+ (id)dayWithDate:(NSDate *) date {
    return [[self alloc] initWithDate:date];
}

- (id)initWithYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day {
    self = [self init];
    if (self == nil) {
        return nil;
    }

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit;
    _components = [[NSDateComponents alloc] init];
    [_components setYear:year];
    [_components setMonth:month];
    [_components setDay:day];
    _date = [calendar dateFromComponents:self.components];

    return self;
}

- (NSInteger)getYear {
    return [self.components year];
}

- (NSInteger)getMonth {
    return [self.components month];
}

- (NSInteger)getDay {
    return [self.components day];
}
// create NSDateComponent each time
// http://smallmakeprgnote.wordpress.com/2012/01/27/nsdatecomponents-%E3%81%A7%E4%BB%8A%E6%9C%881%E6%97%A5%E3%81%AE%E6%9B%9C%E6%97%A5%E3%82%92%E5%8F%96%E5%BE%97/
- (NSInteger)getWeekDay {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:self.date];
    return [components weekday];
}

- (NSComparisonResult)compare:(AZCalDay *) calDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [[calendar dateFromComponents:self.components] compare:[calendar dateFromComponents:calDay.components]];
}

- (BOOL)isToday {
    AZCalDay *calDayForToday = [[AZCalDay alloc] initWithDate:[NSDate date]];
    return [self isEqualToDay:calDayForToday];
}

- (BOOL)isEqualToDay:(AZCalDay *) other {
    NSDateComponents *components1 = self.components;
    NSDateComponents *components2 = other.components;
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.date=%@", self.date];
    [description appendString:@">"];
    return description;
}


@end