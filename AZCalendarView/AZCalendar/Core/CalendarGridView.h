//
//  CalendarGridView.h
//  ZHJCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalDay.h"

@protocol CalendarGridViewDelegate;

@interface CalendarGridView : UIView
{
    BOOL        _selected;
    BOOL _selectedEnable;
    
    NSUInteger  _row;
    NSUInteger  _column;
    
    NSString    *_identifier;
    
    CalDay      *_calDay;
    
    id<CalendarGridViewDelegate> __unsafe_unretained _delegate;
}

@property (nonatomic, unsafe_unretained) id<CalendarGridViewDelegate> delegate;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL selectedEnable;

@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) NSUInteger column;

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) CalDay *calDay;

- (void) select;
- (void) deselect;

+ (CalendarGridView*) viewFromNib; 

+ (CalendarGridView*) viewFromNibWithIdentifier:(NSString*)identifier; 

@end

@protocol CalendarGridViewDelegate <NSObject>
@optional
- (void) calendarGridViewDidSelectGrid:(CalendarGridView*) gridView;
@end
