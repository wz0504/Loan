//
//  LoanDetailModel.h
//  Loan
//
//  Created by FanXing on 2018/3/6.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanDetailModel : NSObject
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
//所需资料<title>
@property (nonatomic,strong) NSArray * material_str;
//参考月息
@property(nonatomic,copy)NSString * monthly_s;
//申请资格
@property(nonatomic,copy)NSString * seniority;
//是否关注 1 是 2 否
@property (nonatomic,assign) NSInteger is_coll;
//口子id
@property(nonatomic,copy)NSString * ID;
@end
