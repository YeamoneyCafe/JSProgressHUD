//
//  YMProgressHUD.m
//  ZXDProgressHUD
//
//  Created by jersey on 24/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "YMProgressHUD.h"

#import "YMDevice.h"
#import "UIViewController+YMTool.h"
#import "MBProgressHUD+YMProgressHUD.h"
#import <objc/runtime.h>
#import <Aspects.h>

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
    if ([YMDevice currentDevice].systemVersion.floatValue <= 9.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        //防止alertView动画跟键盘动画冲突
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView show];
        });
    } else {
        UIViewController* topVC = [UIViewController ym_visibleViewController];
        UIAlertController* alertView = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"辅助操作" style:UIAlertActionStyleDefault handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"主操作" style:UIAlertActionStyleCancel handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"111操作" style:UIAlertActionStyleDestructive handler:nil]];
        [topVC presentViewController:alertView animated:YES completion:nil];
    }

}

//Alert提醒框、可设置按钮Text。
+ (void)showAlertMessage:(NSString *)message affirmText:(NSString *)affirmText
{
    
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message cancelText:(NSString *)cancelText affirmText:(NSString *)affirmText cancelBlock:(completionblock)cancelBlock affirmblock:(completionblock)affirmblock alertShowcompletion:(completionblock)alertShowcompletion;
{
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cancelBlock ? cancelBlock() : NULL;
        }];
        UIAlertAction* affirmAction = [UIAlertAction actionWithTitle:affirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            affirmblock ? affirmblock() : NULL;
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:affirmAction];
        UIViewController* topVC = [UIViewController ym_visibleViewController];
        [topVC presentViewController:alertController animated:YES completion:^{
            alertShowcompletion ? alertShowcompletion() : NULL;
        }];
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message buttonsText:(NSArray<NSString *> *)buttonsText completionblock:(void (^)(NSInteger))completionblock
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [buttonsText enumerateObjectsUsingBlock:^(NSString * _Nonnull text, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionblock ? completionblock(idx) : NULL;
        }];
        [alertController addAction:action];
    }];
    UIViewController* topVC = [UIViewController ym_visibleViewController];
    [topVC presentViewController:alertController animated:YES completion:^{
        
    }];
    
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
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *finalView = [view isKindOfClass:[UIWindow class]] ? view : view.window;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:finalView];
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.customView.frame = CGRectMake(0, 0, 28, 28);
        hud.detailsLabelText = text;
        [self setupHUD:hud];
        hud.completionBlock = completion;
        hud.minSize = CGSizeMake(120, 120);
        [finalView addSubview:hud];
        [hud adjustCenterAfterLayout:hud text:text];
        [hud show:YES];
        [hud hide:YES afterDelay:YMProgressHUDTextDelay];
    });
}

//文本提醒，自定义图像，设置HUD大小 停留1.5s，完成后执行completion
+ (void)showText:(NSString *)text customeView:(UIView *)customeView HUDMinSize:(CGSize)minSize onView:(UIView *)view completion:(completionblock)completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView* finalView = [view isKindOfClass:[UIWindow class]] ? view : [UIApplication sharedApplication].delegate.window;
        MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:finalView];
//        hud.touchbeg = YES;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = customeView;
        hud.detailsLabelText = text;
        //如果最小值宽高有设置、则使用。否则使用默认的 120、120。
        hud.minSize = (minSize.width || minSize.height) ? minSize : CGSizeMake(120, 120);
        hud.completionBlock = completion;
        [self setupHUD:hud];
        [finalView addSubview:hud];
        [hud adjustCenterAfterLayout:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:YMProgressHUDTextDelay];
    });
}
//loading HUD,可带文字
+ (YMProgressHUD *)showLoadingOnView:(UIView *)view text:(NSString *)text
{
    YMProgressHUD *progressHUD = [[YMProgressHUD alloc] init];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    view2.backgroundColor = [UIColor blueColor];
    hud.customView = view2;
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

#pragma mark -- Privat Method

+ (void)adjustCenterAfterLayout:(MBProgressHUD *)hud text:(NSString *)text
{
    [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        CGRect rect = hud.customView.frame;
        rect.origin.y -= 8;
        hud.customView.frame = rect;
        for (id obj in hud.subviews) {
            if ([obj isMemberOfClass:[UILabel class]]) {
                NSString* objText = [obj objectForKey:@"text"];
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

