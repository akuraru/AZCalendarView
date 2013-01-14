//
//  Created by azu on 12/12/19.
//


#import "AZCalendarWeekHintView.h"


@implementation AZCalendarWeekHintView {

}

@synthesize title = _title;
@synthesize dayOfWeek = _dayOfWeek;


+ (AZCalendarWeekHintView *)viewFromNib {
    Class selfClass = [self class];
    return [[[NSBundle bundleForClass:selfClass] loadNibNamed:NSStringFromClass(selfClass) owner:self options:nil]
                       objectAtIndex:0];
}

+ (AZCalendarWeekHintView *)viewFromNibWithIdentifier:(NSString *)identifier {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
    AZCalendarWeekHintView *weekHintView = [array objectAtIndex:0];
    weekHintView.identifier = identifier;
    return weekHintView;
}
@end