//
//  RootNavigationController.h
//  Loan
//
//  Created by FanXing on 2017/11/18.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationController : UINavigationController
/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;
@end
