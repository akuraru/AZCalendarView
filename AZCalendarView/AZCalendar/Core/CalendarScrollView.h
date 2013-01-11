//
//  CalendarScrollView.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-5-21.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarScrollViewDelegate;

@interface CalendarScrollView : UIScrollView {
    id <CalendarScrollViewDelegate> __unsafe_unretained _calendarDelegate;
}

@property(nonatomic, unsafe_unretained) id <CalendarScrollViewDelegate> calendarDelegate;

@end

@protocol CalendarScrollViewDelegate <NSObject>

@optional
- (void)calendarScrollViewTouchesBegan:(CalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesMoved:(CalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesEnded:(CalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)calendarScrollViewTouchesCancelled:(CalendarScrollView *)calendarScrollView touches:(NSSet *)touches
        withEvent:(UIEvent *)event;
@end
