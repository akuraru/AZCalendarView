//
//  AZCalendarScrollView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-5-21.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarScrollViewDelegate;

@interface AZCalendarScrollView : UIScrollView {
    id <CalendarScrollViewDelegate> __unsafe_unretained _calendarDelegate;
}

@property(nonatomic, unsafe_unretained) id <CalendarScrollViewDelegate> calendarDelegate;

@end

@protocol CalendarScrollViewDelegate <NSObject>

@optional
- (void)calendarScrollViewTouchesBegan:(AZCalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesMoved:(AZCalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesEnded:(AZCalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesCancelled:(AZCalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;
@end
