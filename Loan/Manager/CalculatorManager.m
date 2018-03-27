//
//  CalculatorManager.m
//  Loan
//
//  Created by FanXing on 2017/11/27.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "CalculatorManager.h"

@implementation CalculatorManager

- (instancetype)initWithCalculatorType:(CalculatorManagerType)calculatorType Money:(CGFloat)money Time:(int)time MonthRate:(CGFloat)rate RepaymentWay:(NSInteger)way
{
    self = [super init];
    if (self) {
        [self calculatorType:calculatorType Money:money Time:time MonthRate:rate RepaymentWay:way];
    }
    return self;
}

-(void)calculatorType:(CalculatorManagerType)calculatorType Money:(CGFloat)money Time:(int)time MonthRate:(CGFloat)rate RepaymentWay:(NSInteger)way {
    
    //信用卡分期计算器
    if (calculatorType == CalculatorManagerTypeValue3) {
        //手续费
        CGFloat serviceCharge = money * rate;
        if (way == 0) {  //分摊收取
            //每月还款
            CGFloat monthMoney = (money + serviceCharge)/time;
            self.serviceCharge = [NSString stringWithFormat:@"%.2f",monthMoney];
            //总还款金额
            self.totalMoney = [NSString stringWithFormat:@"%.2f",money + serviceCharge];
            
        }else if (way ==1){  //一次性收取
            //首月还款
            CGFloat oneMonthMoney = money/time + serviceCharge;
            self.totalMoney = [NSString stringWithFormat:@"%.2f",oneMonthMoney];
            
            //剩余每月还款
            self.serviceCharge = [NSString stringWithFormat:@"%.2f",money/time];
        }
    }else if (calculatorType == CalculatorManagerTypeValue4){ //车贷款计算器
        //每月供款
        CGFloat monthMoney = money*((rate*(pow(1+rate, time)))/(pow(1+rate, time)-1));
        self.serviceCharge = [NSString stringWithFormat:@"%.2f",monthMoney];
        
        //还款总额
        self.totalMoney = [NSString stringWithFormat:@"%.2f",monthMoney*time];
    }
}
@end
