//
//  Created by azu on 12/12/19.
//


#import "BaseCalendarWeekHintView.h"


@implementation BaseCalendarWeekHintView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 押せないようにする
    self.hintButton.userInteractionEnabled = NO;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {

    // フォント色
    UIColor *titleColor = nil;
    if (self.dayOfWeek == Sunday){
        titleColor = [UIColor colorWithRed:234 / 255.0 green:47 / 255.0 blue:61 / 255.0 alpha:1.0];
    } else if (self.dayOfWeek == Saturday){
        titleColor = [UIColor colorWithRed:62 / 255.0 green:138 / 255.0 blue:222 / 255.0 alpha:1.0];
    } else {
        titleColor = [UIColor colorWithRed:122 / 255.0 green:119 / 255.0 blue:122 / 255.0 alpha:1.0];
    }
    [self.hintButton setTitleColor:titleColor forState:UIControlStateNormal];
    // ボタンラベル
    [self.hintButton setTitle:self.title forState:UIControlStateNormal];
    // 背景にセル画像を置く
    [self.hintButton setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
}
@end