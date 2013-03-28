//
//  AZCalDay.h
//  AZCalendar
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"

@interface AZCalDay : NSObject {
@private
    struct {
        unsigned int month : 4;
        unsigned int day : 5;
        unsigned int year : 15;
        unsigned int weekDay : 4;
        //sunday-saturday 1-7
    } day;
}

- (id)initWithDate:(NSDate *)date;

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@property(nonatomic, strong, readonly) NSDate *date;

- (NSUInteger)getYear;

- (NSUInteger)getMonth;

- (NSUInteger)getDay;

- (NSUInteger)getWeekDay;

- (NSComparisonResult)compare:(AZCalDay *)calDay;

- (BOOL)isToday;

- (BOOL)isEqualToDay:(AZCalDay *)calDay;

@end
