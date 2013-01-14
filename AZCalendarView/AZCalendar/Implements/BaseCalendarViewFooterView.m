//
//  BaseCalendarViewFooterView.m
//

#import "BaseCalendarViewFooterView.h"

@implementation BaseCalendarViewFooterView

+ (AZCalendarViewFooterView *)viewFromNib {
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
