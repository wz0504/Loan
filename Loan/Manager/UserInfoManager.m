//
//  UserInfoManager.m
//  FlashPayBo
//
//  Created by FanXing on 2017/12/23.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager
+(void)saveAccount:(UserInfo *)userInfo {
    [NSKeyedArchiver archiveRootObject:userInfo toFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.plist"]];
    DLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.plist"]);
}

+(UserInfo *)getAccountInfo {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.plist"]];
}

+(void)updateAccount:(UserInfo *)userInfo {
    [[self class] removeAccountInfo];
    [[self class] saveAccount:userInfo];
}
+(void)removeAccountInfo {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.plist"] error:nil];
    
}
@end
