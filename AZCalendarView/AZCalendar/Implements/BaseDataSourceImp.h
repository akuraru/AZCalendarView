//
//  BaseDataSourceImp.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZCalendarViewDataSource.h"

@interface BaseDataSourceImp : NSObject <AZCalendarViewDataSource>

- (void)updateGridView:(AZCalendarGridView *)gridView calendarGridViewForRow:(NSInteger)row column:(NSInteger)column
        calDay:(AZCalDay *)calDay;

@end
