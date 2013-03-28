//
// Created by azu on 2013/03/28.
//


#import "Kiwi.h"
#import "AZCalDay.h"
#import "NSDate+AZBuilder.h"

@interface AZCalDaySpec : KWSpec

@end

@implementation AZCalDaySpec

+ (void)buildExampleGroups {
    describe(@"AZCalDay", ^{
        describe(@"#initWithDate:", ^{
            it(@"should be return AZCalDay", ^{
                AZCalDay *day = [[AZCalDay alloc] initWithDate:[NSDate date]];
                [[day should] isKindOfClass:[AZCalDay class]];
            });
        });
        describe(@"#initWithYear:month:day::", ^{
            it(@"should return AZCalDay", ^{
                AZCalDay *calDay = [[AZCalDay alloc] initWithYear:2012 month:2 day:24];
                [[calDay should] isKindOfClass:[AZCalDay class]];
            });
        });
        context(@"@property", ^{
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 12;
            NSUInteger aDay = 24;
            __block AZCalDay *calDay;
            beforeEach(^{
                calDay = [[AZCalDay alloc] initWithYear:aYear month:aMonth day:aDay];
                [[calDay should] isKindOfClass:[AZCalDay class]];
            });
            describe(@"#getYear", ^{
                it(@"should return 2012", ^{
                    [[theValue([calDay getYear])should] equal:theValue(aYear)];
                });
            });
            describe(@"#getMonth", ^{
                it(@"should return 12", ^{
                    [[theValue([calDay getMonth])should] equal:theValue(aMonth)];
                });
            });
            describe(@"#getDay", ^{
                it(@"should return 24", ^{
                    [[theValue([calDay getDay])should] equal:theValue(aDay)];
                });
            });
            describe(@"#getWeekDay", ^{
                NSDate *aDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(aYear),
                        azDateUnit.month : @(aMonth),
                        azDateUnit.day : @(aDay),
                }];
                it(@"weekday", ^{
                    AZCalDay *sCalDay = [[AZCalDay alloc] initWithYear:aYear month:aMonth day:aDay];
                    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
                    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    NSDateComponents *components = [gregorian components:unitFlags fromDate:aDate];
                    NSInteger expectWeekDay = [components weekday];
                    [[theValue([calDay getWeekDay]) should] equal:theValue(expectWeekDay)];
                    [[theValue([sCalDay getWeekDay]) should] equal:theValue(expectWeekDay)];
                });
            });
        });
        describe(@"#isToday", ^{
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 12;
            NSUInteger aDay = 2;
            __block NSDate *aDate;
            beforeEach(^{
                aDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(aYear),
                        azDateUnit.month : @(aMonth),
                        azDateUnit.day : @(aDay),
                }];
                [NSDate stub:@selector(date) andReturn:aDate];
            });
            context(@"initWithDate:aDate == aDate", ^{
                it(@"should be true", ^{
                    AZCalDay *calDay = [[AZCalDay alloc] initWithDate:aDate];
                    [[theValue([calDay isToday]) should] beYes];
                });
            });
            context(@"is not today", ^{
                it(@"should be false", ^{
                    AZCalDay *differentDay = [[AZCalDay alloc] initWithYear:2200 month:aMonth day:aDay];
                    [[theValue([differentDay isToday]) should] beNo];
                });
            });
        });
        describe(@"#isEqualToDay", ^{
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 12;
            NSUInteger aDay = 24;
            __block NSDate *aDate;
            beforeEach(^{
                aDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(aYear),
                        azDateUnit.month : @(aMonth),
                        azDateUnit.day : @(aDay),
                }];
            });
            context(@"initWithDate: and initWitYear:...", ^{
                it(@"should be true", ^{
                    AZCalDay *calDay = [[AZCalDay alloc] initWithDate:aDate];
                    AZCalDay *anotherDay = [[AZCalDay alloc] initWithYear:aYear month:aMonth day:aDay];
                    BOOL isEqualToDay = [calDay isEqualToDay:anotherDay];
                    [[theValue(isEqualToDay) should] beYes];
                });
            });
            context(@"initWith different day", ^{
                it(@"should be false", ^{
                    AZCalDay *calDay = [[AZCalDay alloc] initWithDate:aDate];
                    AZCalDay *differentDay = [[AZCalDay alloc] initWithYear:2200 month:aMonth day:aDay];
                    BOOL isEqualToDay = [calDay isEqualToDay:differentDay];
                    [[theValue(isEqualToDay) should] beNo];
                });
            });
        });

        describe(@"compare", ^{
            // a < b < c
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 12;
            NSUInteger aDay = 1;

            NSUInteger bYear = 2013;
            NSUInteger bMonth = 12;
            NSUInteger bDay = 24;

            NSUInteger cYear = 2013;
            NSUInteger cMonth = 12;
            NSUInteger cDay = 25;
            __block NSDate *aDate;
            __block NSDate *bDate;
            __block NSDate *cDate;
            __block AZCalDay *aCalDay;
            __block AZCalDay *bCalDay;
            __block AZCalDay *cCalDay;

            beforeEach(^{
                aDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(aYear),
                        azDateUnit.month : @(aMonth),
                        azDateUnit.day : @(aDay),
                }];
                bDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(bYear),
                        azDateUnit.month : @(bMonth),
                        azDateUnit.day : @(bDay),
                }];
                cDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @(cYear),
                        azDateUnit.month : @(cMonth),
                        azDateUnit.day : @(cDay),
                }];
                aCalDay = [[AZCalDay alloc] initWithDate:aDate];
                bCalDay = [[AZCalDay alloc] initWithDate:bDate];
                cCalDay = [[AZCalDay alloc] initWithDate:cDate];
            });
            // left < right
            it(@"a < b - NSOrderedAscending", ^{
                NSComparisonResult comparisonResult = [aCalDay compare:bCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedAscending)];
            });
            it(@"b < c - NSOrderedAscending", ^{
                NSComparisonResult comparisonResult = [bCalDay compare:cCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedAscending)];
            });
            it(@"a < c - NSOrderedAscending", ^{
                NSComparisonResult comparisonResult = [aCalDay compare:cCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedAscending)];
            });
            // same
            it(@"a == a - NSOrderedSame", ^{
                NSComparisonResult comparisonResult = [aCalDay compare:aCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedSame)];
            });
            // right < left
            it(@"b < a - NSOrderedDescending", ^{
                NSComparisonResult comparisonResult = [bCalDay compare:aCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedDescending)];
            });
            it(@"c < b - NSOrderedDescending", ^{
                NSComparisonResult comparisonResult = [cCalDay compare:bCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedDescending)];
            });
            it(@"c < a - NSOrderedDescending", ^{
                NSComparisonResult comparisonResult = [cCalDay compare:aCalDay];
                [[theValue(comparisonResult) should] equal:theValue(NSOrderedDescending)];
            });
        });
    });
}

@end