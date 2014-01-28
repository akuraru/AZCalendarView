//
//  ThirdViewController.h
//  AZCalendarView
//
//  Created by azu on 01/28/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "AZCalendarViewDelegate.h"

@class ThirdCalendarView;
@class ThirdDataSourceImp;

@interface ThirdViewController : UIViewController <AZCalendarViewDelegate>

@property (nonatomic,strong)ThirdCalendarView *calendarView;
@property (nonatomic,strong)ThirdDataSourceImp *dataSource;
@end
