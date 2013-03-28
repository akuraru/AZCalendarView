//
// Created by azu on 2013/03/28.
//


#import <Foundation/Foundation.h>

@class AZCalDay;


@interface AZCalMonth : NSObject

- (id)initWithDate:(NSDate *)date;

- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year day:(NSUInteger)day;

- (AZCalDay *)calDayAtDay:(NSUInteger)day;

- (AZCalDay *)firstDay;

- (AZCalDay *)lastDay;

- (NSUInteger)getYear;

- (NSUInteger)getMonth;

- (AZCalMonth *)nextMonth;

- (AZCalMonth *)previousMonth;

- (NSUInteger)days;
@end