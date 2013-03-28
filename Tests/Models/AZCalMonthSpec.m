//
// Created by azu on 2013/03/28.
//


#import "Kiwi.h"
#import "AZCalMonth.h"
#import "AZCalDay.h"
#import "NSDate+AZBuilder.h"

@interface AZCalMonthSpec : KWSpec

@end

@implementation AZCalMonthSpec

+ (void)buildExampleGroups {
    describe(@"AZCalMonth", ^{
        describe(@"#initWithDate", ^{
            it(@"should be AZCalMonth", ^{
                AZCalMonth *calMonth = [[AZCalMonth alloc] initWithDate:[NSDate date]];
                [[calMonth should] isKindOfClass:[AZCalMonth class]];
            });
        });
        describe(@"#initWithMonth:year:day:", ^{

            NSUInteger aYear = 2012;
            NSUInteger aMonth = 12;
            NSUInteger aDay = 24;

            it(@"should be AZCalMonth", ^{
                AZCalMonth *calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                [[calMonth should] isKindOfClass:[AZCalMonth class]];
            });
        });
        describe(@"#firstDay", ^{
            context(@"When 2000/01", ^{
                NSUInteger aYear = 2000;
                NSUInteger aMonth = 1;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return AZCalDay", ^{
                    [[[calMonth firstDay] should] isKindOfClass:[AZCalDay class]];
                });
                it(@"should return 2000/01/01", ^{
                    AZCalDay *firstDay = [calMonth firstDay];
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(aYear),
                            azDateUnit.month : @(aMonth),
                            azDateUnit.day : @(1)
                    }];
                    AZCalDay *expectDay = [[AZCalDay alloc] initWithDate:expectDate];
                    [[theValue([firstDay isEqualToDay:expectDay]) should] beYes];
                });
            });
        });
        describe(@"#lastDay", ^{
            context(@"When 2000/01", ^{
                NSUInteger aYear = 2000;
                NSUInteger aMonth = 1;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return AZCalDay", ^{
                    [[[calMonth lastDay] should] isKindOfClass:[AZCalDay class]];
                });
                it(@"should return 2000/01/31", ^{
                    AZCalDay *lastDay = [calMonth lastDay];
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(aYear),
                            azDateUnit.month : @(aMonth),
                            azDateUnit.day : @(31)
                    }];
                    AZCalDay *expectDay = [[AZCalDay alloc] initWithDate:expectDate];
                    [[theValue([lastDay isEqualToDay:expectDay]) should] beYes];
                });
            });
            context(@"When 2012/02", ^{
                NSUInteger aYear = 2012;
                NSUInteger aMonth = 2;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                // leap date
                it(@"should return 2012/02/29", ^{
                    AZCalDay *lastDay = [calMonth lastDay];
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(aYear),
                            azDateUnit.month : @(aMonth),
                            azDateUnit.day : @(29)
                    }];
                    AZCalDay *expectDay = [[AZCalDay alloc] initWithDate:expectDate];
                    [[theValue([lastDay isEqualToDay:expectDay]) should] beYes];
                });
            });
        });
        describe(@"#getYear", ^{
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 2;
            NSUInteger aDay = 5;
            __block AZCalMonth *calMonth;
            beforeEach(^{
                calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
            });
            it(@"should return 2012", ^{
                [[theValue([calMonth getYear]) should] equal:theValue(aYear)];
            });
        });
        describe(@"#getMonth", ^{
            NSUInteger aYear = 2012;
            NSUInteger aMonth = 2;
            NSUInteger aDay = 5;
            __block AZCalMonth *calMonth;
            beforeEach(^{
                calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
            });
            it(@"should return 2", ^{
                [[theValue([calMonth getMonth]) should] equal:theValue(aMonth)];
            });
        });

        describe(@"#nextMonth", ^{

            context(@"across year", ^{
                NSUInteger aYear = 2012;
                NSUInteger aMonth = 12;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return 2013/1", ^{
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(2013),
                            azDateUnit.month : @(1),
                            azDateUnit.day : @(5)
                    }];
                    AZCalMonth *expectMonth = [[AZCalMonth alloc] initWithDate:expectDate];
                    AZCalMonth *nextMonth = [calMonth nextMonth];
                    [[theValue([nextMonth getMonth]) should] equal:theValue([expectMonth getMonth])];
                    [[theValue([nextMonth getYear]) should] equal:theValue([expectMonth getYear])];
                });
            });
            context(@"in year", ^{
                NSUInteger aYear = 2012;
                NSUInteger aMonth = 1;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return 2013/1", ^{
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(2012),
                            azDateUnit.month : @(2),
                            azDateUnit.day : @(5)
                    }];
                    AZCalMonth *expectMonth = [[AZCalMonth alloc] initWithDate:expectDate];
                    AZCalMonth *nextMonth = [calMonth nextMonth];
                    [[theValue([nextMonth getMonth]) should] equal:theValue([expectMonth getMonth])];
                    [[theValue([nextMonth getYear]) should] equal:theValue([expectMonth getYear])];
                });
            });
        });
        describe(@"#previousMonth", ^{
            context(@"in year", ^{
                NSUInteger aYear = 2012;
                NSUInteger aMonth = 12;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return 2012/11", ^{
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(2012),
                            azDateUnit.month : @(11),
                            azDateUnit.day : @(5)
                    }];
                    AZCalMonth *expectMonth = [[AZCalMonth alloc] initWithDate:expectDate];
                    AZCalMonth *previousMonth = [calMonth previousMonth];
                    [[theValue([previousMonth getMonth]) should] equal:theValue([expectMonth getMonth])];
                    [[theValue([previousMonth getYear]) should] equal:theValue([expectMonth getYear])];
                });
            });
            context(@"across year", ^{
                NSUInteger aYear = 2012;
                NSUInteger aMonth = 1;
                NSUInteger aDay = 5;
                __block AZCalMonth *calMonth;
                beforeEach(^{
                    calMonth = [[AZCalMonth alloc] initWithMonth:aMonth year:aYear day:aDay];
                });
                it(@"should return 2011/12", ^{
                    NSDate *expectDate = [NSDate dateByUnit:@{
                            azDateUnit.year : @(2011),
                            azDateUnit.month : @(12),
                            azDateUnit.day : @(5)
                    }];
                    AZCalMonth *expectMonth = [[AZCalMonth alloc] initWithDate:expectDate];
                    AZCalMonth *previousMonth = [calMonth previousMonth];
                    [[theValue([previousMonth getMonth]) should] equal:theValue([expectMonth getMonth])];
                    [[theValue([previousMonth getYear]) should] equal:theValue([expectMonth getYear])];
                });
            });
        });
    });
}

@end