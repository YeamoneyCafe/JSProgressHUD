//
//  ZXDLaunchVC.m
//  ZXDProgressHUD
//
//  Created by jersey on 22/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "ZXDLaunchVC.h"

#import "ZXDPublic.h"

@interface ZXDLaunchVC ()

@end

@implementation ZXDLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置view
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //请求StartInfo成功并检查版本通过才能跳转到首页或欢迎页
    //    [YMStartInfo getStartInfoSuccess:^{
    //        @weakify(self)
    //        [YMCheckVersion checkWithPass:^{
    //            @strongify(self);
    //            [self reloadView];
    //        }];
    //    }];
    [self reloadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.设置view和样式

- (void)setupView
{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:self.viewModel.image];
//    [self.view addSubview:imageView];
//    self.imageView = imageView;
}

- (void)reloadView
{
//    //下载启动广告图片
//    [[YMLaunchAdvertManager shareManager] downloadAdvertImage];
//
//    //跳到欢迎页
//    if ([self shouldShowGuidePage]) {
//        YMWelcomeVC *welcomeVC = [[YMWelcomeVC alloc] init];
//        //欢迎页结束Handler
//        welcomeVC.completeHandler = ^{
//            //已经展示引导页标志为yes
//            self.isShowGuidePage = YES;
//            //跳到首页
//            YMRootTabBarController *tabVC = [[YMRootTabBarController alloc] init];
//            [self restoreRootViewController:tabVC];
//        };
//        [self restoreRootViewController:welcomeVC];
//    }
//    //展示广告再跳到首页
//    else {
//        CGRect adFrame = self.view.bounds;
//        adFrame.size.height = CGRectGetHeight(self.view.bounds) * (1 - 0.19);
//        @weakify(self)
//        [[YMLaunchAdvertManager shareManager] showAdvertViewWithFrame:adFrame onView:self.view skipHandler:^{
//            @strongify(self)
//            //跳到首页
//            YMRootTabBarController *tabVC = [[YMRootTabBarController alloc] init];
//            [self restoreRootViewController:tabVC];
//        }];
//    }
    //先跳转至首页
//    ZXDRootViewController *rootTabVC = [[ZXDRootViewController alloc] init];
//    [self replaceWindowRootViewControoler:rootTabVC];
      ZXDHomeVC* homeVC = [[ZXDHomeVC alloc] init];
      [self replaceWindowRootViewControoler:homeVC];
}

#pragma mark - 3.自定义方法
//更换Window的rootViewController
- (void)replaceWindowRootViewControoler:(UIViewController *)rootViewController
{
    UIWindow* window = [UIApplication sharedApplication].delegate.window;
    [UIView transitionWithView:window duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [window setRootViewController:rootViewController];
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {

    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
