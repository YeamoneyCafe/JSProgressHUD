//
//  UIViewController+YMTool.m
//  YEAMoney
//
//  Created by 乔腾龙 on 16/8/16.
//  Copyright © 2016年 YEAMoney. All rights reserved.
//

#import "UIViewController+YMTool.h"
//#import "YMDataService.h"

@implementation UIViewController (YMTool)

- (void)ym_hideNavLine:(BOOL)isHidden
{
//    NSArray *arry = [self.navigationController.navigationBar subviews];
//    for (UIView *view in arry) {
//        NSString *viewName = NSStringFromClass([view class]);
//        if ([viewName isEqualToString:@"_UINavigationBarBackground"]) {
//            UIImageView *line = [view valueForKey:@"_shadowView"];
//            line.hidden = isHidden;
//        }
//    }
    UIImageView *lineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    lineImageView.hidden = isHidden;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//- (void)setSepline:(UIView *)view
//{
//    for (int i = 0; i < 2; i ++) {
//        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, i * (view.frame.size.height - SepLine_Height), view.frame.size.width, SepLine_Height)];
//        line.backgroundColor = [UIColor colorWithWhite:204.0f / 255.0f alpha:1.0f];
//        [view addSubview:line];
//    }
//}
//
//- (void)postNotisForUpdateUserMoney
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kYMUpdateUserMoneyNotification object:nil];
//}

#pragma mark - Find ViewController

//返回根控制器
//TODO:多次push、modal交替，有子父vc的情况待测试
- (void)ym_backToRootViewController:(BOOL)animated
{
    //vc是present出来的
    if (self.presentingViewController) {
        //找到底层的presentingVC，dismiss
        UIViewController *presentingVC = self;
        while (presentingVC.presentingViewController) {
            presentingVC = presentingVC.presentingViewController;
        }
        [presentingVC dismissViewControllerAnimated:animated completion:nil];
        //底层的presentingVC继续backToRoot
        [presentingVC ym_backToRootViewController:animated];
    }
    //vc是push出来的
    else if (self.navigationController) {
        //导航控制器继续backToRoot
        [self.navigationController ym_backToRootViewController:animated];
    }
    //vc是标签控制器
    else if ([self isKindOfClass:[UITabBarController class]]) {
        [((UITabBarController *)self).selectedViewController ym_backToRootViewController:animated];
    }
    //vc是导航控制器
    else if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self popToRootViewControllerAnimated:animated];
    }
//    //vc有父vc，可能与vc是UITabBarController的情况产生死循环
//    else if (self.parentViewController) {
//        //父vc继续backToRoot
//        [self.parentViewController ym_backToRootViewController:animated];
//    }
}

//根UIViewController
+ (UIViewController *)ym_rootViewController
{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

//当前可见VC
//TODO:多次push、modal交替，有子父vc，侧边栏的情况待测试
//TODO:通过nextResponder找
+ (UIViewController *)ym_visibleViewController
{    
    UIViewController *rootVc = [self ym_rootViewController];
    UIViewController *visibleVC = [rootVc ym_topViewController];
    return visibleVC;
}

//顶部可见控制器
//TODO:多次push、modal交替，有子父vc的情况待测试
- (UIViewController *)ym_topViewController
{
    //vc有presented vc
    if (self.presentedViewController) {
        //找 presented vc 的 top vc
        return [self.presentedViewController ym_topViewController];
    }
    //vc是UITabBarController
    else if ([self isKindOfClass:[UITabBarController class]]) {
        //找顶层 selected vc 的 top vc
        return [((UITabBarController *)self).selectedViewController ym_topViewController];
    }
    //vc是UINavigationController
    else if ([self isKindOfClass:[UINavigationController class]]) {
        //找顶层 visible vc 的 top vc
        return [((UINavigationController *)self).visibleViewController ym_topViewController];
    }
//    //vc有父vc，可能与vc是UITabBarController的情况产生死循环
//    else if (self.parentViewController) {
//        //找父vc的 top vc
//        return [self.parentViewController ym_topViewController];
//    }
    //top vc 为自己
    return self;
}


@end
