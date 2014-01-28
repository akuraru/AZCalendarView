//
//  AZCalendarGridView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalDay.h"

@protocol CalendarGridViewDelegate;

@interface AZCalendarGridView : UIView {
    BOOL _selected;
    BOOL _canSelect;

    NSUInteger _row;
    NSUInteger _column;

    NSString *_identifier;

    AZCalDay *_calDay;

    id <CalendarGridViewDelegate> __unsafe_unretained _delegate;
}

@property(nonatomic, unsafe_unretained) id <CalendarGridViewDelegate> delegate;

@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) BOOL canSelect;

@property(nonatomic, assign) NSUInteger row;
@property(nonatomic, assign) NSUInteger column;

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) AZCalDay *calDay;

- (void)select;

- (void)deselect;

+ (AZCalendarGridView *)viewFromNib;

+ (AZCalendarGridView *)viewFromNibWithIdentifier:(NSString *)identifier;

@end

@protocol CalendarGridViewDelegate <NSObject>

@optional
- (void)calendarGridViewDidSelectDay:(AZCalDay *) calDay;
@end
