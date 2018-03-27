//
//  UserInfoManager.h
//  FlashPayBo
//
//  Created by FanXing on 2017/12/23.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject
+(void)saveAccount:(UserInfo *)userInfo;
+(UserInfo *)getAccountInfo;
+(void)updateAccount:(UserInfo *)userInfo;
+(void)removeAccountInfo;
@end
