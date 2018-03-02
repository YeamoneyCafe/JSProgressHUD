//
//  YMProductAssignApplyConfirmView.m
//  YEAMoney
//
//  Created by suke on 2017/9/15.
//  Copyright © 2017年 YEAMoney. All rights reserved.
//

#import "YMProductAssignApplyConfirmView.h"

@implementation YMProductAssignApplyConfirmView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Method

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *bgView = [[UIView alloc] initWithFrame:window.bounds];
    [window addSubview:bgView];
    [bgView addSubview:self];
    
    bgView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }];
    
    self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.superview.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}

@end
