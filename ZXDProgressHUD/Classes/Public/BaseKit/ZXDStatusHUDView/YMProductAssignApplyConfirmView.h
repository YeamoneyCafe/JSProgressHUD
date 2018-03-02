//
//  YMProductAssignApplyConfirmView.h
//  YEAMoney
//
//  Created by suke on 2017/9/15.
//  Copyright © 2017年 YEAMoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMProductAssignApplyConfirmView : UIView

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *adjustAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *realAmountLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (void)show;
- (void)dismiss;

@end
