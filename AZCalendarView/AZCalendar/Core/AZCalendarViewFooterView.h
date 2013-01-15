//
//  AZCalendarViewFooterView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZCalendarEnum.h"

@protocol CalendarViewFooterViewDelegate;

@interface AZCalendarViewFooterView : UIView
{
    UIButton *_selectedButton;   
    id<CalendarViewFooterViewDelegate> __unsafe_unretained _delegate;
}

@property (nonatomic, unsafe_unretained) id<CalendarViewFooterViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *selectedButton;

+ (AZCalendarViewFooterView *) viewFromNib;

@end

@protocol CalendarViewFooterViewDelegate <NSObject>
@optional
- (void) calendarViewFooterViewDidSelectPeriod:(AZCalendarViewFooterView *)footerView periodType:(PeriodType)type;
@end

