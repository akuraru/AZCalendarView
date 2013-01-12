//
//  BaseCalendarViewHeaderView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "BaseCalendarViewHeaderView.h"

@interface BaseCalendarViewHeaderView ()

@property(strong, nonatomic) IBOutlet UILabel *monthLabel;

@end


@implementation BaseCalendarViewHeaderView

@synthesize monthLabel;

- (IBAction)onCancelChoseDateButtonTouched:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(calendarViewHeaderViewDidCancel:)]){
        [_delegate calendarViewHeaderViewDidCancel:self];
    }
}

- (IBAction)onChoseDateButtonTouched:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(calendarViewHeaderViewDidSelection:)]){
        [_delegate calendarViewHeaderViewDidSelection:self];
    }
}

- (IBAction)onPreviousMonthButtonTouched:(id)sender {
    if (_delegate && [_delegate respondsToSelector:
                                    @selector(calendarViewHeaderViewPreviousMonth:)]){
        [_delegate calendarViewHeaderViewPreviousMonth:self];
    }
}

- (IBAction)onNextMonthButtonTouched:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(calendarViewHeaderViewNextMonth:)]){
        [_delegate calendarViewHeaderViewNextMonth:self];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.monthLabel.text = title;
}
@end
