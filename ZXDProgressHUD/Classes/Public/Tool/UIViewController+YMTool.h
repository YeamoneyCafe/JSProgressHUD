//
//  UIViewController+YMTool.h
//  YEAMoney
//
//  Created by 乔腾龙 on 16/8/16.
//  Copyright © 2016年 YEAMoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YMTool)

/**
 *  隐藏/显示 导航栏底部的分隔线
 *
 *  @param isHidden 是否隐藏
 */
- (void)ym_hideNavLine:(BOOL)isHidden;


/**
 *  设置View顶部和底部的分隔线(2条)
 *
 *  @param view 需要设置的View
 */
- (void)setSepline:(UIView *)view;

/**
 *  广播更新userMoney的通知
 */
- (void)postNotisForUpdateUserMoney;

#pragma mark - Find ViewController

- (void)ym_backToRootViewController:(BOOL)animated; //返回根控制器
+ (UIViewController *)ym_rootViewController;        //根UIViewController
+ (UIViewController *)ym_visibleViewController;     //当前可见UIViewController

@end
