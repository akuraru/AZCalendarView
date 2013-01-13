//
//  CalendarGridView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalendarGridView.h"

@implementation CalendarGridView

@synthesize row = _row;
@synthesize column = _column;
@synthesize selected = _selected;
@synthesize calDay = _calDay;
@synthesize delegate = _delegate;
@synthesize identifier = _identifier;
@synthesize canSelect = _canSelect;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _selected = NO;
    _canSelect = YES;
}

- (void)select {
}

- (void)deselect {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+ (CalendarGridView *)viewFromNib {
    Class selfClass = [self class];
    return [[[NSBundle bundleForClass:selfClass] loadNibNamed:NSStringFromClass(selfClass) owner:self options:nil]
                       objectAtIndex:0];
}

+ (CalendarGridView *)viewFromNibWithIdentifier:(NSString *)identifier {
    CalendarGridView *gridView = [self viewFromNib];
    gridView.identifier = identifier;
    return gridView;
}
@end
