//
//  ZXDAlertTextFieldView.m
//  ZXDProgressHUD
//
//  Created by jersey on 30/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "ZXDAlertTextFieldView.h"

@implementation ZXDAlertTextFieldView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
}

- (void)show
{
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    UIView* bgView = [[UIView alloc] initWithFrame:window.frame];
    UIButton* btn = [[UIButton alloc] initWithFrame:window.frame];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:bgView];
    [bgView addSubview:btn];
    [bgView addSubview:self];
    
    bgView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3f animations:^{
       bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }];
    
    self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.alpha = 0;
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alpha = 1.0;
    } completion:nil];
    
}

-(void)dismiss
{
    [self endEditing:YES];
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}

- (void)tap{
    
    [self endEditing:YES];
    
}

@end
