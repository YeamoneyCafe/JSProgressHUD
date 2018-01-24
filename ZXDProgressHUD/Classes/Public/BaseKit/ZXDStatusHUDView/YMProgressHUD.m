//
//  YMProgressHUD.m
//  ZXDProgressHUD
//
//  Created by jersey on 24/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "YMProgressHUD.h"

//文本提示停留时间
static NSTimeInterval const YMProgressHUDTextDelay = 1.5;
//API错误提示类型
typedef NS_ENUM(NSInteger, YMAPIErrorHUDType) {
    YMAPIErrorHUDTypeAlert  = -101, // 弹框提示
    YMAPIErrorHUDTypeText   = -102, // 吐司提示
};

@interface YMProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation YMProgressHUD

/**
 *  弹出API错误提示
 *
 *  @param error 错误信息
 */
+ (void)showAPIError:(NSError *)error
{
    switch (error.code) {
        case YMAPIErrorHUDTypeAlert:  // 弹框提示
        {
            [YMProgressHUD showAlertMessage:error.domain];
        }
            break;
        case YMAPIErrorHUDTypeText:  // 吐司提示
        {
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            [YMProgressHUD showText:error.domain onView:window];
        }
            break;
            
        default:  // 缺省为吐司提示
        {
            if (error.domain.length) {
                UIWindow *window = [UIApplication sharedApplication].delegate.window;
                [YMProgressHUD showText:error.domain onView:window];
            }
        }
            break;
    }
}

//Alert提醒框
+ (void)showAlertMessage:(NSString *)message
{
    if (message.length == 0) {
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    //防止alertView动画跟键盘动画冲突
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

//文本提醒,停留1.5s
+ (void)showText:(NSString *)text onView:(UIView *)view
{
    [self showText:text onView:view completion:nil];
}

//文本提醒，停留1.5s，完成后执行completion
+ (void)showText:(NSString *)text onView:(UIView *)view completion:(void (^)(void))completion
{
    UIView *finalView = [view isKindOfClass:[UIWindow class]] ? view : view.window;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:finalView];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    //    hud.labelText = text;
    hud.detailsLabelText = text;
    [self setupHUD:hud];
    hud.completionBlock = completion;
    [finalView addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:YMProgressHUDTextDelay];
}

//文本提醒，自定义图像，停留1.5s，完成后执行completion
+ (void)showText:(NSString *)text image:(UIImage*)image onView:(UIView *)view completion:(void (^)(void))completion
{
    UIView *finalView = [view isKindOfClass:[UIWindow class]] ? view : view.window;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:finalView];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
//        hud.labelText = text;
    hud.detailsLabelText = text;
    [self setupHUD:hud];
    hud.completionBlock = completion;
    hud.minSize = CGSizeMake(120, 120);
    [finalView addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:YMProgressHUDTextDelay];
    
}

//loading HUD,可带文字
+ (YMProgressHUD *)showLoadingOnView:(UIView *)view text:(NSString *)text
{
    YMProgressHUD *progressHUD = [[YMProgressHUD alloc] init];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    //    hud.labelText = text;
    hud.detailsLabelText = text;
    [self setupHUD:hud];
    [view addSubview:hud];
    [hud show:YES];
    
    progressHUD.hud = hud;
    return progressHUD;
}

//设置HUD样式UI
+ (void)setupHUD:(MBProgressHUD *)hud
{
    UIActivityIndicatorView *indicator = [hud valueForKey:@"indicator"];
    if ([indicator isKindOfClass:[UIActivityIndicatorView class]]) {
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.opacity = 0.5;
    hud.cornerRadius = 5.0;
    hud.color = [UIColor colorWithWhite:0.1 alpha:0.7];
}

#pragma mark - Method

/**
 *  隐藏HUD，弹出API错误提示
 *
 *  @param error 错误信息
 */
- (void)hideWithAPIError:(NSError *)error
{
    switch (error.code) {
        case YMAPIErrorHUDTypeAlert:  // 弹框提示
        {
            [self hideWithText:nil completion:nil];
            [YMProgressHUD showAlertMessage:error.domain];
        }
            break;
        case YMAPIErrorHUDTypeText:  // 吐司提示
        {
            [self hideWithText:error.domain completion:nil];
        }
            break;
            
        default:  // 缺省为吐司提示
        {
            [self hideWithText:error.domain completion:nil];
        }
            break;
    }
}

#pragma mark --

//隐藏loading HUD,弹出Alert提醒框
- (void)hideWithAlert:(NSString *)text
{
    [self hideWithText:nil completion:nil];
    [YMProgressHUD showAlertMessage:text];
}

//隐藏loading HUD,可带文字,停留1.5s
- (void)hideWithText:(NSString *)text
{
    [self hideWithText:text completion:nil];
}

//隐藏loading HUD,可带文字,停留1.5s，完成后执行completion
- (void)hideWithText:(NSString *)text completion:(void (^)(void))completion
{
    self.hud.completionBlock = completion;
    if (text.length) {
        self.hud.mode = MBProgressHUDModeText;
        //        self.hud.labelText = text;
        self.hud.detailsLabelText = text;
        [self.hud hide:YES afterDelay:YMProgressHUDTextDelay];
    } else {
        [self.hud hide:NO];
    }
}


@end

