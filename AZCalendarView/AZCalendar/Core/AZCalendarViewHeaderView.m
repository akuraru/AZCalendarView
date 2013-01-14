//
//  AZCalendarViewHeaderView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "AZCalendarViewHeaderView.h"

@implementation AZCalendarViewHeaderView

@synthesize title = _title;
@synthesize delegate = _delegate;
@synthesize previousMonthButton;
@synthesize nextMonthButton;

+ (AZCalendarViewHeaderView *)viewFromNib {
    Class selfClass = [self class];
    return [[[NSBundle bundleForClass:selfClass] loadNibNamed:NSStringFromClass(selfClass) owner:self options:nil]
                       objectAtIndex:0];
}
@end
