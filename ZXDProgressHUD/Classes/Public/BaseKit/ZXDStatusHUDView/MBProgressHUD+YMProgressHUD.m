//
//  MBProgressHUD+YMProgressHUD.m
//  YEAMoney
//
//  Created by jersey on 30/1/18.
//  Copyright © 2018年 YEAMoney. All rights reserved.
//

#import "MBProgressHUD+YMProgressHUD.h"

#import <objc/runtime.h>
#import <Aspects.h>

@implementation MBProgressHUD (YMProgressHUD)

- (void)adjustCenterAfterLayout:(MBProgressHUD *)hud
{
    [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        CGRect rect = hud.customView.frame;
        rect.origin.y -= 20;
        hud.customView.frame = rect;
    } error:NULL];
}

- (void)adjustCenterAfterLayout:(MBProgressHUD *)hud text:(NSString *)text
{
    [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        CGRect rect = hud.customView.frame;
        rect.origin.y -= 8;
        hud.customView.frame = rect;
        for (id obj in hud.subviews) {
            if ([obj isMemberOfClass:[UILabel class]]) {
                NSString* objText = [obj valueForKey:@"text"];
                if ([objText isEqualToString:text]) {
                    UILabel* label = obj;
                    CGRect rect = label.frame;
                    rect.origin.y += 8;
                    label.frame = rect;
                }
            }
        }
    } error:NULL];
    
}
@end
