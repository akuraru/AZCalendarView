//
//  BaseCalendarDisableGridView.m
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "AZCalendarGridView.h"
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

- (void)layoutSubviews {
    NSString *buttonDayTitle = [NSString stringWithFormat:@"%d", [_calDay getDay]];
    [self.gridButton setTitle:buttonDayTitle forState:UIControlStateNormal];
    UIColor *grayColor = [UIColor colorWithRed:122 / 255.0 green:119 / 255.0 blue:122 / 255.0 alpha:1.0];
    [self.gridButton setTitleColor:grayColor forState:UIControlStateNormal];
}

+ (AZCalendarGridView *)viewFromNib {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return [super viewFromNib];
    } else {
        Class selfClass = [self class];
        NSString *iPad = [NSStringFromClass(selfClass) stringByAppendingString:@"_iPad"];
        return [[[NSBundle bundleForClass:selfClass] loadNibNamed:iPad owner:self options:nil]
                           objectAtIndex:0];
    }
}

@end
