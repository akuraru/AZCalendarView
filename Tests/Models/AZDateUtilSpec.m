//
// Created by azu on 2013/03/28.
//


#import "Kiwi.h"
#import "AZDateUtil.h"
#import "NSDate+AZBuilder.h"

@interface AZDateUtilSpec : KWSpec

@end

@implementation AZDateUtilSpec

+ (void)buildExampleGroups {
    describe(@"AZDateUtil", ^{
        context(@"when normal day", ^{
            __block NSDate *normalDate;
            beforeEach(^{
                normalDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @2020,
                        azDateUnit.month : @12,
                        azDateUnit.day : @25,
                }];
                [NSDate stub:@selector(date) andReturn:normalDate];
            });
            describe(@"#numberOfDaysInMonth", ^{
                it(@"should be 31", ^{
                    NSInteger days = [AZDateUtil numberOfDaysInMonthDate:normalDate];
                    [[@(days) should] equal:@31];
                });
            });
            describe(@"#getCurrentYear", ^{
                it(@"should be 2020", ^{
                    NSInteger year = [AZDateUtil getCurrentYear];
                    [[theValue(year) should] equal:theValue(2020)];
                });
            });
            describe(@"#getCurrentMonth", ^{
                it(@"should be 12", ^{
                    NSInteger month = [AZDateUtil getCurrentMonth];
                    [[theValue(month) should] equal:theValue(12)];
                });
            });
            describe(@"#getCurrentDay", ^{
                it(@"should be 25", ^{
                    NSInteger days = [AZDateUtil getCurrentDay];
                    [[theValue(days) should] equal:theValue(25)];
                });
            });
        });
        context(@"when leap day", ^{
            __block NSDate *leapDate;
            beforeEach(^{
                leapDate = [NSDate dateByUnit:@{
                        azDateUnit.year : @2012,
                        azDateUnit.month : @2,
                        azDateUnit.day : @9,
                }];
                [NSDate stub:@selector(date) andReturn:leapDate];
            });
            describe(@"#numberOfDaysInMonth", ^{
                it(@"should be leap", ^{
                    NSInteger days = [AZDateUtil numberOfDaysInMonthDate:leapDate];
                    [[@(days) should] equal:@29];
                });
            });
            describe(@"#getCurrentYear", ^{
                it(@"should be 2012", ^{
                    NSInteger year = [AZDateUtil getCurrentYear];
                    [[theValue(year) should] equal:theValue(2012)];
                });
            });
            describe(@"#getCurrentMonth", ^{
                it(@"should be 2", ^{
                    NSInteger month = [AZDateUtil getCurrentMonth];
                    [[theValue(month) should] equal:theValue(2)];
                });
            });
            describe(@"#getCurrentDay", ^{
                it(@"should be 9", ^{
                    NSInteger days = [AZDateUtil getCurrentDay];
                    [[theValue(days) should] equal:theValue(9)];
                });
            });
        });
    });
}

@end