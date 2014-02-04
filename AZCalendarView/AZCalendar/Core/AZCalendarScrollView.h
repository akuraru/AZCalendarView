//
// Created by azu on 2013/08/14.
//


#import <Foundation/Foundation.h>

@class AZCalendarScrollView;

@protocol CalendarScrollViewDelegate <NSObject>
@optional
- (void)calendarScrollViewTouchesBegan:(AZCalendarScrollView *) calendarScrollView touches:(NSSet *) touches
                             withEvent:(UIEvent *) event;

- (void)calendarScrollViewTouchesMoved:(AZCalendarScrollView *) calendarScrollView touches:(NSSet *) touches
                             withEvent:(UIEvent *) event;

- (void)calendarScrollViewTouchesEnded:(AZCalendarScrollView *) calendarScrollView touches:(NSSet *) touches
                             withEvent:(UIEvent *) event;

- (void)calendarScrollViewTouchesCancelled:(AZCalendarScrollView *) calendarScrollView touches:(NSSet *) touches
                                 withEvent:(UIEvent *) event;
@end

@interface AZCalendarScrollView : UIScrollView
@property(nonatomic) NSObject <CalendarScrollViewDelegate> *calendarScrollViewDelegate;
@end

