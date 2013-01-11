//
//  CalendarViewHeaderView.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalendarViewHeaderView.h"

@implementation CalendarViewHeaderView

@synthesize title = _title;
@synthesize delegate = _delegate;
@synthesize previousMonthButton;
@synthesize nextMonthButton;

+ (CalendarViewHeaderView*) viewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
}
@end
