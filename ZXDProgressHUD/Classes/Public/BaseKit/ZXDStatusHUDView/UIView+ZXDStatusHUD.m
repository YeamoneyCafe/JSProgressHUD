//
//  UIView+ZXDStatusHUD.m
//  ZXDProgressHUD
//
//  Created by jersey on 22/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "UIView+ZXDStatusHUD.h"

@implementation UIView (ZXDStatusHUD)

-(void)ZXD_showText:(NSString *)text customView:(UIView *)view HUDWeight:(CGFloat)weight HUDHeight:(CGFloat)height onView:(UIView *)onView
{
    
    onView = onView ? onView : [UIApplication sharedApplication].delegate.window;
    NSAssert(view, @"View must not be nil.");
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:onView];
    hud.mode = MBProgressHUDModeCustomView;
    if (weight && height) {
        hud.minSize = CGSizeMake(weight, height);
    } else {
        hud.minSize = CGSizeMake(120, 120);
    }
//    hud.labelText = text;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    hud.detailsLabelColor = [UIColor whiteColor];
    hud.labelFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    hud.labelColor = [UIColor whiteColor];
    hud.customView = view;
    hud.removeFromSuperViewOnHide = YES;
    hud.cornerRadius = 5.0f;
    hud.margin = 0;
    [onView addSubview:hud];
    [hud show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}

@end
