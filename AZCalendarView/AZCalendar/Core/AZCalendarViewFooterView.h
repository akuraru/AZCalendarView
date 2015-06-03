//
//  AZCalendarViewFooterView.h
//  AZCalendar
//
//  Created by huajian zhou on 12-4-12.
//  Copyright (c) 2012年 Sword.Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZCalendarEnum.h"

@interface AZCalendarViewFooterView : UIView {
    UIButton *_selectedButton;
}

@property(nonatomic, strong) IBOutlet UIButton *selectedButton;

+ (AZCalendarViewFooterView *)viewFromNib;

@end


