//
//  BaseCalendarDisableGridView.m
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalendarGridView.h"
#import "BaseCalendarDisableGridView.h"

@interface BaseCalendarDisableGridView ()

@property(strong, nonatomic) IBOutlet UIButton *gridButton;

@end

@implementation BaseCalendarDisableGridView

@synthesize gridButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.gridButton.userInteractionEnabled = NO;
}

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
- (void)select {
    self.selected = TRUE;
    self.gridButton.selected = TRUE;
}

- (void)deselect {
    self.selected = FALSE;
    self.gridButton.selected = FALSE;
}

- (void)layoutSubviews {
    NSString *title = [NSString stringWithFormat:@"%d", [_calDay getDay]];
    [self.gridButton setTitle:title forState:UIControlStateNormal];
    [self.gridButton setTitleColor:
                         [UIColor colorWithRed:122 / 255.0 green:119 / 255.0 blue:122 / 255.0 alpha:1.0] forState:UIControlStateNormal];

    self.gridButton.selected = self.selected;
}
@end
