//
//  Created by azu on 12/12/19.
//


#import "BaseCalendarWeekHintView.h"


@implementation BaseCalendarWeekHintView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // don't select
    self.weekHintCellButton.userInteractionEnabled = NO;
}

- (void)layoutSubviews {

    // Saturday is blue , Sunday is red Color
    UIColor *titleColor = nil;
    if (self.dayOfWeek == Sunday){
        titleColor = [UIColor colorWithRed:234 / 255.0 green:47 / 255.0 blue:61 / 255.0 alpha:1.0];
    } else if (self.dayOfWeek == Saturday){
        titleColor = [UIColor colorWithRed:62 / 255.0 green:138 / 255.0 blue:222 / 255.0 alpha:1.0];
    } else {
        titleColor = [UIColor colorWithRed:122 / 255.0 green:119 / 255.0 blue:122 / 255.0 alpha:1.0];
    }
    [self.weekHintCellButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self.weekHintCellButton setTitle:self.title forState:UIControlStateNormal];
    [self.weekHintCellButton setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
}

+ (AZCalendarWeekHintView *)viewFromNib {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return [super viewFromNib];
    } else {
        Class selfClass = [self class];
        NSString *iPad = [NSStringFromClass(selfClass) stringByAppendingString:@"_iPad"];
        return [[[NSBundle bundleForClass:selfClass] loadNibNamed:iPad owner:self options:nil]
                           objectAtIndex:0];
    }
}

@end