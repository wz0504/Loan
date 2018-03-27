//
//  NSString+DYGAdd.h
//  test
//
//  Created by Mr_Du on 2017/10/29.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (DYGAdd)
//MD5加密
- (NSString *) md5;
//是否纯数字
-(BOOL)isPureNum;
-(instancetype)translateToMandarinLatin;//转换成汉语拼音 不带音调
-(instancetype)firstLetter; //首字母
//手机号判断
-(BOOL)isValidMobile;
//字体size
-(CGSize)sizeForFont:(UIFont *)font size:(CGSize)size;
//字体高度
-(CGFloat)heightWithFont:(UIFont *)font;
//字体宽度
-(CGFloat)widthWithFont:(UIFont *)font;

@end
