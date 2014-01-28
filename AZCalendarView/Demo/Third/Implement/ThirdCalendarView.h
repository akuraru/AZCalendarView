//
//  Created by azu on 13/01/13.
//


#import <Foundation/Foundation.h>
#import "AZCalendarView.h"
#import "BaseCalendarView.h"


@interface ThirdCalendarView : BaseCalendarView
// override views via IBOutlet
@property(strong, nonatomic) IBOutlet UIView *weekHintView;
@property(strong, nonatomic) IBOutlet AZCalendarScrollView *gridScrollView;
@property(strong, nonatomic) IBOutlet UIView *footerView;
@end