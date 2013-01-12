//
//  BaseCalendarGridView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "BaseCalendarGridView.h"

@interface BaseCalendarGridView ()

@property(strong, nonatomic) IBOutlet UIButton *gridButton;

@end

@implementation BaseCalendarGridView

@synthesize gridButton;


- (void)select {
    self.selected = YES;
    self.gridButton.selected = YES;
    self.gridButton.userInteractionEnabled = NO;
}

- (void)deselect {
    self.selected = NO;
    self.gridButton.selected = NO;
    self.gridButton.userInteractionEnabled = YES;
}

- (void)layoutSubviews {
    NSString *buttonDayTitle = [NSString stringWithFormat:@"%d", [_calDay getDay]];
    //  date min / max limit
    if (_canSelect){
        self.gridButton.selected = self.selected;
        // Today Cell
        if ([_calDay isToday]){
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"todaycell.png"] forState:UIControlStateNormal];
            [self.gridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            // bold
            self.gridButton.titleLabel.font = [UIFont boldSystemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
        } else {
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
            [self.gridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.gridButton.titleLabel.font = [UIFont systemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
        }
        // cell is selected
        if (self.selected){
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"date_selected.png"] forState:UIControlStateSelected];
        }
    } else {
        self.gridButton.selected = NO;
        [self.gridButton setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
        [self.gridButton setTitleColor:[UIColor colorWithRed:233 / 255.0 green:232 / 255.0 blue:231 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        self.gridButton.titleLabel.font = [UIFont systemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
    }
    [self.gridButton setTitle:buttonDayTitle forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsLayout];
}
@end
