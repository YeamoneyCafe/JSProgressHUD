//
//  ZXDHomeVC.m
//  ZXDProgressHUD
//
//  Created by jersey on 22/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import "ZXDHomeVC.h"

#import "ZXDHomeView.h"
#import "UIView+ZXDStatusHUD.h"
#import "YMProgressHUD.h"
#import "UIViewController+YMTool.h"
#import "YMProductAssignApplyConfirmView.h"

@interface ZXDHomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) ZXDHomeView *curren;

@end

@implementation ZXDHomeVC

#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar
{
    
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor cyanColor];
    CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    tableView.allowsSelection = NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 5)];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 5)];
    [self.view addSubview:tableView];
    self.tableView = tableView;

    self.curren = [[ZXDHomeView alloc] initWithFrame:self.view.frame];
}

- (void)reloadView
{
    
}

#pragma mark - 3.Request Data

- (void)setupData
{
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"ZXDHUD";
    return cell;
}

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] init];
    UITapGestureRecognizer* tap;
    if (section % 2) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUD)];
    } else {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUDWithAnimation)];
    }
    [view addGestureRecognizer:tap];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 10)];
    label.text = [NSString stringWithFormat:@"分区号%ld",section];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIImageView* customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_infor_gesture"]];
    if (indexPath.section == 0) {
        customView.frame = CGRectMake(0, 0, 28, 28);
        [YMProgressHUD showText:@"网络无法连接" customeView:customView HUDMinSize:CGSizeZero onView:self.view completion:nil];
    } else if (indexPath.section == 1)
    {
        customView.frame = CGRectMake(0, 0, 40, 40);
        [YMProgressHUD showText:@"加载中" customeView:customView HUDMinSize:CGSizeZero onView:self.view completion:nil];
    } else if (indexPath.section == 2)
    {
        customView.frame = CGRectMake(0, 0, 40, 17);
        [YMProgressHUD showText:@"系统出错，正在排查" customeView:customView HUDMinSize:CGSizeMake(200, 104) onView:self.view completion:nil];
    } else if (indexPath.section == 3) {
        [YMProgressHUD showAlertMessage:@"告知当前状态，信息和方案等"];
    } else if (indexPath.section == 4) {
        UIViewController* topVC = [UIViewController ym_visibleViewController];
        UIAlertController* alertView = [UIAlertController alertControllerWithTitle:nil message:@"非默认" preferredStyle:UIAlertControllerStyleActionSheet];
        [alertView addAction:[UIAlertAction actionWithTitle:@"辅助操作" style:UIAlertActionStyleDefault handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"主操作" style:UIAlertActionStyleCancel handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"111操作" style:UIAlertActionStyleDestructive handler:nil]];
        [topVC presentViewController:alertView animated:YES completion:nil];
    } else if (indexPath.section == 5) {
        UIViewController* topVC = [UIViewController ym_visibleViewController];
        UIAlertController* alertView = [UIAlertController alertControllerWithTitle:nil message:@"非默认加输入框" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"辅助操作" style:UIAlertActionStyleDefault handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"主操作" style:UIAlertActionStyleCancel handler:nil]];
        [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"输入的内容为%@",textField.text);
        }];
        [topVC presentViewController:alertView animated:YES completion:nil];
    } else if (indexPath.section == 6) {
        [YMProgressHUD showAlertTitle:@"普通弹窗" message:@"告知当前状态，信息和方案等文字换行" cancelText:@"辅操作" affirmText:@"主操作" cancelBlock:^{
            NSLog(@"执行取消、辅助操作");
        } affirmblock:^{
            NSLog(@"执行确认、主操作");
        } alertShowcompletion:^{
            NSLog(@"弹框以显示出来");
        }];
    } else if (indexPath.section == 7) {
        [YMProgressHUD showAlertTitle:nil message:@"告知当前状态，信息和方案等文字换行" cancelText:@"辅操作" affirmText:@"主操作" cancelBlock:^{
            NSLog(@"执行取消、辅助操作");
        } affirmblock:^{
            NSLog(@"执行确认、主操作");
        } alertShowcompletion:^{
            NSLog(@"弹框以显示出来");
        }];
    } else if (indexPath.section == 8) {
//        [YMProgressHUD showAlertTitle:@"标题文字" message:@"告知当前状态，信息和方案等" buttonsText:@[@"选项一",@"选项二",@"选项三"]];
        [YMProgressHUD showAlertTitle:@"标题文字" message:@"告知当前状态，信息和方案等" buttonsText:@[@"选项一",@"选项二",@"选项三"] completionblock:^(NSInteger index) {
            if (index == 0) {
                NSLog(@"点击选项一");
            } else if (index == 1) {
                NSLog(@"点击选项二");
            } else if (index == 2) {
                NSLog(@"点击选项三");
            }
        }];
    } else if (indexPath.section == 9) {
//        YMProductAssignApplyConfirmView* view = [YMProductAssignApplyConfirmView ym_viewWithFrame:CGRectMake(0, 0, 280, 239)];
        YMProductAssignApplyConfirmView* view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YMProductAssignApplyConfirmView class]) owner:nil options:nil].lastObject;
        view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [view show];
        
    } else if (indexPath.section == 10) {
        
    }
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification
{
    
}

- (void)hideHUD{
    
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    
}

- (void)hideHUDWithAnimation{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)afterShowHUD
{
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD = HUD;
    self.HUD.dimBackground = YES;
    self.HUD.removeFromSuperViewOnHide = YES;
    self.HUD.xOffset = 0.0f;
    self.HUD.yOffset = 0.0f;
    self.HUD.margin = 0.0f;
    self.HUD.cornerRadius = 0.0f;
    self.HUD.mode = MBProgressHUDModeCustomView;
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    view.backgroundColor = [UIColor yellowColor];
    self.HUD.customView = view;
    self.HUD.labelText = @"失败提醒";
    self.HUD.detailsLabelText = @"系统出错，";
    self.HUD.graceTime = 5;
    self.HUD.taskInProgress = YES;
    self.HUD.minSize = CGSizeMake(200, 104);
    self.HUD.color = [UIColor blueColor];
    
//    self.
    [self.view addSubview:self.HUD];
//    [HUD show:YES];
//    NSLog(@"开始显示HUD:::%@",HUD);
//    [HUD showAnimated:YES whileExecutingBlock:^{
////        sleep(5);
//        NSLog(@"HUD:::%@",HUD);
//        NSLog(@"正在显示中-------");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"查看%@",HUD);
//            NSLog(@"%@---",self.HUD);
//        });
//    }];
    [HUD show:YES];
    
//    [self performSelector:@selector(afterHideHUD) withObject:nil afterDelay:2.0f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.HUD hide:YES];
        NSLog(@"%@---",self.HUD);
    });
}

- (void)afterHideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - 7.GET & SET

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation MBProgressHUD(UIView)

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [MBProgressHUD hideHUDForView:self animated:YES];
//}

@end

@implementation UIView(UIViewLayout)



@end
