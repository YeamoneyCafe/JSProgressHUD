//
//  ZXDAlertTextFieldView.h
//  ZXDProgressHUD
//
//  Created by jersey on 30/1/18.
//  Copyright © 2018年 YeamoneyCafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDAlertTextFieldView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *affirmButton;

- (void)show;
- (void)dismiss;

@end
