//
//  BaseCalendarGridView.m
//  ZHJCalendar
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
    self.gridButton.userInteractionEnabled = FALSE;
}

- (void)deselect {
    self.selected = FALSE;
    self.gridButton.selected = FALSE;
    self.gridButton.userInteractionEnabled = TRUE;
}

- (UIImageView *)imageViewForName:(NSString *)name {
    if ([name isEqualToString:@"朝"]){
        return self.morningImageView;
    } else if ([name isEqualToString:@"昼"]){
        return self.noonImageView;
    } else if ([name isEqualToString:@"夜"]){
        return self.nightImageView;
    }
}

- (void)layoutSubviews {
    NSString *title = [NSString stringWithFormat:@"%d", [_calDay getDay]];
    // min / max 日付制限により選択できるかどうか
    if (_selectedEnable){
        self.gridButton.selected = self.selected;
        if ([_calDay isToday]){
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"todaycell.png"] forState:UIControlStateNormal];
            [self.gridButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            // 太字にする
            self.gridButton.titleLabel.font = [UIFont boldSystemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
        } else {
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
            [self.gridButton setTitleColor:
                                 [UIColor colorWithRed:122 / 255.0 green:119 / 255.0 blue:122 / 255.0 alpha:1.0] forState:UIControlStateNormal];
            self.gridButton.titleLabel.font = [UIFont systemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
        }

        if (self.selected){
            [self.gridButton setBackgroundImage:[UIImage imageNamed:@"date_selected.png"] forState:UIControlStateSelected];
        }
    } else {
        self.gridButton.selected = FALSE;
        [self.gridButton setBackgroundImage:[UIImage imageNamed:@"todaycell.png"] forState:UIControlStateNormal];
        [self.gridButton setTitleColor:[UIColor colorWithRed:233 / 255.0 green:232 / 255.0 blue:231 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        self.gridButton.titleLabel.font = [UIFont systemFontOfSize:[self.gridButton.titleLabel.font pointSize]];
    }
    [self.gridButton setTitle:title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsLayout];
}
@end
