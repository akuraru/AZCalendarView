//
//  BaseDataSourceImp.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarViewDataSource.h"

@interface BaseDataSourceImp : NSObject <CalendarViewDataSource>

- (void)updateGridView:(CalendarGridView *)gridView calendarGridViewForRow:(NSInteger)row column:(NSInteger)column
        calDay:(CalDay *)calDay;

@end
