//
//  AZCalendarViewHeaderView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalendarViewHeaderViewDelegate;

@interface AZCalendarViewHeaderView : UIView
{
    NSString        *_title;
    id<CalendarViewHeaderViewDelegate> _delegate;
}

@property (nonatomic, strong) id<CalendarViewHeaderViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *previousMonthButton;
@property (nonatomic, strong) IBOutlet UIButton *nextMonthButton;
@property (nonatomic, strong) NSString *title;

+ (AZCalendarViewHeaderView *) viewFromNib;

@end

@protocol CalendarViewHeaderViewDelegate <NSObject>
@optional
- (void) calendarViewHeaderViewNextMonth:(AZCalendarViewHeaderView *)calendarHeaderView;
- (void) calendarViewHeaderViewPreviousMonth:(AZCalendarViewHeaderView *)calendarHeaderView;
- (void) calendarViewHeaderViewDidCancel:(AZCalendarViewHeaderView *)calendarHeaderView;
- (void) calendarViewHeaderViewDidSelection:(AZCalendarViewHeaderView *)calendarHeaderView;
@end
