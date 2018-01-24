//
//  YMProgressHUD.h
//  ZXDProgressHUD
//
//  Created by jersey on 24/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionblock)(void);

@interface YMProgressHUD : NSObject

//弹出API错误提示
+ (void)showAPIError:(NSError *)error;
//Alert提醒框
+ (void)showAlertMessage:(NSString *)message;
//文本提醒,停留1.5s
+ (void)showText:(NSString *)text onView:(UIView *)view;
//文本提醒，自定义图像，停留1.5s，完成后执行completion
+ (void)showText:(NSString *)text image:(UIImage *)image onView:(UIView *)view completion:(completionblock)completion;
//文本提醒，自定义图像，停留1.5s，完成后执行completion
//+ (void)showText:(NSString *)text customimage:(UIImage *)image imageSize onView:(UIView *)view completion:(completionblock)completion;
//文本提醒，停留1.5s，完成后执行completion
+ (void)showText:(NSString *)text onView:(UIView *)view completion:(completionblock)completion;
//loading HUD,可带文字
+ (YMProgressHUD *)showLoadingOnView:(UIView *)view text:(NSString *)text;

//隐藏HUD，弹出API错误提示
- (void)hideWithAPIError:(NSError *)error;
//隐藏HUD,弹出Alert提醒框
- (void)hideWithAlert:(NSString *)text;
//隐藏HUD,可带文字,停留1.5s
- (void)hideWithText:(NSString *)text;
//隐藏HUD,可带文字,停留1.5s，完成后执行completion
- (void)hideWithText:(NSString *)text completion:(completionblock)completion;

@end
