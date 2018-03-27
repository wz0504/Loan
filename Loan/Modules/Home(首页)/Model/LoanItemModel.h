//
//  LoanItemModel.h
//  Loan
//
//  Created by FanXing on 2018/3/5.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanItemModel : NSObject
//标题
@property(nonatomic,copy)NSString * entrance;
//图片
@property(nonatomic,copy)NSString * img_path;
//地址
@property(nonatomic,copy)NSString * url;
//类型
@property(nonatomic,copy)NSString * type;
@end
