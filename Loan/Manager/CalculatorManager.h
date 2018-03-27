//
//  CalculatorManager.h
//  Loan
//
//  Created by FanXing on 2017/11/27.
//  CokAdaptedHeightright © 2017年 FanXing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CalculatorManagerType) {
    CalculatorManagerTypeDefault,    //房贷计算器
    CalculatorManagerTypeValue1,     //存款计算器
    CalculatorManagerTypeValue2,     //基金计算器
    CalculatorManagerTypeValue3,     //信用卡分期计算器
    CalculatorManagerTypeValue4,     //车贷款计算器
};

@interface CalculatorManager : NSObject
@property (nonatomic,copy) NSString *totalMoney;  //总金额
@property (nonatomic,copy) NSString *serviceCharge; //利息、每月还款、手续费


/**
 贷款计算器
 @param calculatorType 计算器类型
 @param money  贷款金额
 @param time 贷款期限
 @param rate 贷款月利率
 @param way 还款方式
 */
- (instancetype)initWithCalculatorType:(CalculatorManagerType)calculatorType Money:(CGFloat)money Time:(int)time MonthRate:(CGFloat)rate RepaymentWay:(NSInteger)way;
@end
