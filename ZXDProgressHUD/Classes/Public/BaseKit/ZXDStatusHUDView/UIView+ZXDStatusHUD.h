//
//  UIView+ZXDStatusHUD.h
//  ZXDProgressHUD
//
//  Created by jersey on 22/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZXDStatusHUD)

- (void)ZXD_showText:(NSString* )text customView:(UIView* )view HUDWeight:(CGFloat )weight HUDHeight:(CGFloat)height onView:(UIView* )onview;

@end
