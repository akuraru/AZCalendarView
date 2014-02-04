//
// Created by azu on 2013/08/14.
//


#import "AZCalendarScrollView.h"


@implementation AZCalendarScrollView {

}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event {
    [super touchesBegan:touches withEvent:event];
    if ([self.calendarScrollViewDelegate respondsToSelector:@selector(calendarScrollViewTouchesBegan:touches:withEvent:)]) {
        [self.calendarScrollViewDelegate calendarScrollViewTouchesBegan:self touches:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event {
    [super touchesMoved:touches withEvent:event];
    if ([self.calendarScrollViewDelegate respondsToSelector:@selector(calendarScrollViewTouchesMoved:touches:withEvent:)]) {
        [self.calendarScrollViewDelegate calendarScrollViewTouchesMoved:self touches:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event {
    [super touchesEnded:touches withEvent:event];
    if ([self.calendarScrollViewDelegate respondsToSelector:@selector(calendarScrollViewTouchesEnded:touches:withEvent:)]) {
        [self.calendarScrollViewDelegate calendarScrollViewTouchesEnded:self touches:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *) touches withEvent:(UIEvent *) event {
    [super touchesCancelled:touches withEvent:event];
    if ([self.calendarScrollViewDelegate respondsToSelector:@selector(calendarScrollViewTouchesCancelled:touches:withEvent:)]) {
        [self.calendarScrollViewDelegate calendarScrollViewTouchesCancelled:self touches:touches withEvent:event];
    }
}
@end