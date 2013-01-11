//
//  Created by azu on 12/12/19.
//


#import <Foundation/Foundation.h>


NS_ENUM(NSUInteger, ZHJ_DayOfWeek){
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
};

@interface CalendarWeekHintView : UIView {
}

@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, copy) NSString *title;
@property(nonatomic) enum ZHJ_DayOfWeek dayOfWeek;


+ (CalendarWeekHintView *)viewFromNib;

+ (CalendarWeekHintView *)viewFromNibWithIdentifier:(NSString *)identifier;

@end