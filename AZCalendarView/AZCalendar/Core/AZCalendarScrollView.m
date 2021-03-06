//
//  AZCalendarScrollView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-5-21.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "AZCalendarScrollView.h"

@implementation AZCalendarScrollView

@synthesize calendarDelegate = _calendarDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.multipleTouchEnabled = TRUE;
}

- (void)dealloc {
    _calendarDelegate = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(calendarScrollViewTouchesBegan:touches:withEvent:)]){
        [_calendarDelegate calendarScrollViewTouchesBegan:self touches:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(calendarScrollViewTouchesMoved:touches:withEvent:)]){
        [_calendarDelegate calendarScrollViewTouchesMoved:self touches:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(calendarScrollViewTouchesEnded:touches:withEvent:)]){
        [_calendarDelegate calendarScrollViewTouchesEnded:self touches:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(calendarScrollViewTouchesCancelled:touches:withEvent:)]){
        [_calendarDelegate calendarScrollViewTouchesCancelled:self touches:touches withEvent:event];
    }
}
@end
