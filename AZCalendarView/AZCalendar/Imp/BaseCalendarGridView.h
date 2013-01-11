//
//  BaseCalendarGridView.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import "CalendarGridView.h"

@interface BaseCalendarGridView : CalendarGridView
@property (weak, nonatomic) IBOutlet UIImageView *morningImageView;
@property (weak, nonatomic) IBOutlet UIImageView *noonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nightImageView;

@property (weak, nonatomic) IBOutlet UIImageView *recordImageView;
- (UIImageView *)imageViewForName:(NSString *)name;


@end
