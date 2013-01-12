//
//  CalendarViewFooterView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZCalendarEnum.h"

@protocol CalendarViewFooterViewDelegate;

@interface CalendarViewFooterView : UIView
{
    UIButton *_selectedButton;   
    id<CalendarViewFooterViewDelegate> __unsafe_unretained _delegate;
}

@property (nonatomic, unsafe_unretained) id<CalendarViewFooterViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *selectedButton;

+ (CalendarViewFooterView*) viewFromNib;

@end

@protocol CalendarViewFooterViewDelegate <NSObject>
@optional
- (void) calendarViewFooterViewDidSelectPeriod:(CalendarViewFooterView*)footerView periodType:(PeriodType)type;
@end

