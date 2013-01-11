//
//  CalendarViewHeaderView.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalendarViewHeaderViewDelegate;

@interface CalendarViewHeaderView : UIView
{
    NSString        *_title;
    id<CalendarViewHeaderViewDelegate> _delegate;
}

@property (nonatomic, strong) id<CalendarViewHeaderViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *previousMonthButton;
@property (nonatomic, strong) IBOutlet UIButton *nextMonthButton;
@property (nonatomic, strong) NSString *title;

+ (CalendarViewHeaderView*) viewFromNib;

@end

@protocol CalendarViewHeaderViewDelegate <NSObject>
@optional
- (void) calendarViewHeaderViewNextMonth:(CalendarViewHeaderView*)calendarHeaderView;
- (void) calendarViewHeaderViewPreviousMonth:(CalendarViewHeaderView*)calendarHeaderView;
- (void) calendarViewHeaderViewDidCancel:(CalendarViewHeaderView*)calendarHeaderView;
- (void) calendarViewHeaderViewDidSelection:(CalendarViewHeaderView*)calendarHeaderView;
@end
