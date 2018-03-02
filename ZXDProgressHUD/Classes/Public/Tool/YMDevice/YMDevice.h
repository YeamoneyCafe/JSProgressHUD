//
//  YMDevice.h
//  YEAMoney
//
//  Created by suke on 16/6/22.
//  Copyright © 2016年 YEAMoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDevice : NSObject

@property (nonatomic, copy) NSString *UUID;//设备ID
@property (nonatomic, copy) NSString *name;//设备名
@property (nonatomic, copy) NSString *machine;//设备型号
@property (nonatomic, copy) NSString *systemName;//系统名称
@property (nonatomic, copy) NSString *systemVersion;//系统版本
@property (nonatomic, copy) NSString *resolution;//设备分辨率

+ (YMDevice *)currentDevice;

- (NSString *)infoJsonString;
- (NSString *)infoJsonBase64String;

@end
