//
//  FXGetUrl.m
//  SuperPocket
//
//  Created by FanXing on 2017/10/26.
//  CokAdaptedHeightright © 2017年 FanXing. All rights reserved.
//

#import "FXGetUrl.h"

@implementation FXGetUrl

/**
 * 传入参数与url，拼接为一个带参数的url
 **/
+(NSString *) connectUrl:(NSMutableDictionary *)params url:(NSString *) urlLink{
    // 初始化参数变量
    NSString *str = @"&";
    
    // 快速遍历参数数组
    for(id key in params) {
        //        DYGLog(@"key :%@  value :%@", key, [params objectForKey:key]);
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"="];
        str = [str stringByAppendingString:[params objectForKey:key]];
        str = [str stringByAppendingString:@"&"];
    }
    // 处理多余的&以及返回含参url
    if (str.length > 1) {
        // 去掉末尾的&
        str = [str substringToIndex:str.length - 1];
        str = [str stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
        // 返回含参url
        return [urlLink stringByAppendingString:str];
    }
    return Nil;
}

@end
