//
//  YMDevice.m
//  YEAMoney
//
//  Created by suke on 16/6/22.
//  Copyright © 2016年 YEAMoney. All rights reserved.
//

#import "YMDevice.h"

#import "KeychainItemWrapper.h"
#import <sys/utsname.h>
//#import "YMSecurityTool.h"

@implementation YMDevice

+ (YMDevice *)currentDevice
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (NSString *)infoJsonString
{
    NSString *string = [self infoJson];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}

//- (NSString *)infoJsonBase64String
//{
//    NSString *string = [self infoJson];
//    string = [YMSecurityTool encodeBase64String:string];
//    return string;
//}

- (NSString *)infoJson
{
    NSDictionary *info = @{@"uuid": self.UUID,
                           @"name": self.name,
                           @"machine": self.machine,
                           @"systemName": self.systemName,
                           @"systemVersion": self.systemVersion,
                           @"resolution": self.resolution,
                           };
    NSData *data = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

#pragma mark - Geter / Setter

- (NSString *)UUID
{
    //初始化keychain
    //TODO:搞清楚accessGroup为什么传nil
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
    //从keychain中取uuid
    NSString *uuidString = (NSString *)[wrapper objectForKey:(id)kSecValueData];
    //uuid为空，生成一个并存到keychain
    if (uuidString.length == 0) {
        //生成一个uuid的方法
        uuidString = [[NSUUID UUID] UUIDString];
        //去掉横杠
        //uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //将该uuid保存到keychain
        [wrapper setObject:uuidString forKey:(id)kSecValueData];
    }
    return uuidString;
}

- (NSString *)name
{
    return [UIDevice currentDevice].name;
}

- (NSString *)machine
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineStr = [NSString stringWithCString:systemInfo.machine  encoding:NSUTF8StringEncoding];
    return machineStr;
}

- (NSString *)systemName
{
    return [UIDevice currentDevice].systemName;
}

- (NSString *)systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

- (NSString *)resolution
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale;
    CGFloat height = [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale;
    return [NSString stringWithFormat:@"%@*%@",@(width) ,@(height)];
}

@end

