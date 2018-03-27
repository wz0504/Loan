//
//  LoanModel.h
//  Loan
//
//  Created by FanXing on 2018/3/6.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanModel : NSObject
//标题
@property(nonatomic,copy)NSString * title;
//通过率
@property(nonatomic,copy)NSString * succrate_l;
//最快下款时间
@property(nonatomic,copy)NSString * enter_time;
//申请人数
@property(nonatomic,copy)NSString * apply_num;
//可借贷款  小
@property(nonatomic,copy)NSString * quota_s;
//可借额度 大
@property(nonatomic,copy)NSString * quota_l;
//图片
@property(nonatomic,copy)NSString * img_path;
//宣传文本
@property(nonatomic,copy)NSString * abstr;
//口子id
@property(nonatomic,copy)NSString * ID;

//是否
@property (nonatomic,assign) NSInteger is_recommended;
@end
