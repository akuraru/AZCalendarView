//
//  Created by azu on 12/12/19.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AZ_DayOfWeek){
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
};

@interface AZCalendarWeekHintView : UIView {
}

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, copy) NSString *title;
@property(nonatomic) enum AZ_DayOfWeek dayOfWeek;


+ (AZCalendarWeekHintView *)viewFromNib;

+ (AZCalendarWeekHintView *)viewFromNibWithIdentifier:(NSString *)identifier;

@end
