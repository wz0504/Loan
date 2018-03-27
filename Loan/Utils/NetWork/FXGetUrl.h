//
//  FXGetUrl.h
//  SuperPocket
//
//  Created by FanXing on 2017/10/26.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXGetUrl : NSObject
+(NSString *) connectUrl:(NSMutableDictionary *)params url:(NSString *) urlLink;
@end
