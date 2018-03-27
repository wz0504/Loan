//
//  AppDelegate+AppService.h
//  Loan
//
//  Created by FanXing on 2017/11/18.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]
@interface AppDelegate (AppService)

//单例
+ (AppDelegate *)shareAppDelegate;


/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end
