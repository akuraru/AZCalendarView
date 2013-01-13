//
//  Created by azu on 12/12/19.
//


#import "CalendarWeekHintView.h"


@implementation CalendarWeekHintView {

}

@synthesize title = _title;
@synthesize dayOfWeek = _dayOfWeek;


+ (CalendarWeekHintView *)viewFromNib {
    Class selfClass = [self class];
    return [[[NSBundle bundleForClass:selfClass] loadNibNamed:NSStringFromClass(selfClass) owner:self options:nil]
                       objectAtIndex:0];
}

+ (CalendarWeekHintView *)viewFromNibWithIdentifier:(NSString *)identifier {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    CalendarWeekHintView *weekHintView = [array objectAtIndex:0];
    weekHintView.identifier = identifier;
    return weekHintView;
}
@end