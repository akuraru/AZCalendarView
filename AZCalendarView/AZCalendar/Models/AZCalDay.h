//
// Created by azu on 2013/03/28.
//


#import <Foundation/Foundation.h>


@interface AZCalDay : NSObject
- (id)initWithDate:(NSDate *) date;

- (id)initWithYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day;

+ (id)dayWithDate:(NSDate *) date;

@property(nonatomic, strong, readonly) NSDate *date;
@property(nonatomic, strong) NSDateComponents *components;

- (NSInteger)getYear;

- (NSInteger)getMonth;

- (NSInteger)getDay;

- (NSInteger)getWeekDay;

- (NSComparisonResult)compare:(AZCalDay *) calDay;

- (BOOL)isToday;

- (BOOL)isEqualToDay:(AZCalDay *) calDay;

- (NSString *)description;

@end