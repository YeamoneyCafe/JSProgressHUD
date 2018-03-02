//
//  MBProgressHUD+YMProgressHUD.h
//  YEAMoney
//
//  Created by jersey on 30/1/18.
//  Copyright © 2018年 YEAMoney. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (YMProgressHUD)

- (void)adjustCenterAfterLayout:(MBProgressHUD *)hud;
- (void)adjustCenterAfterLayout:(MBProgressHUD *)hud text:(NSString *)text;

@end
