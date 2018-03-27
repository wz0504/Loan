//
//  NSString+DYGAdd.m
//  test
//
//  Created by Mr_Du on 2017/10/29.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "NSString+DYGAdd.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (DYGAdd)

//MD5加密
- (NSString *) md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

-(BOOL)isPureNum{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.scanLocation = 0;
    NSInteger num;
    if([scan scanInteger:&num] && [scan isAtEnd]){
        return YES;
    }
    return NO;
}
-(instancetype)translateToMandarinLatin{
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)str,0,kCFStringTransformMandarinLatin,NO);
    CFStringTransform((__bridge CFMutableStringRef)str,0,kCFStringTransformStripDiacritics,NO);
    return str.copy;
}
-(instancetype)firstLetter{
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)str,0,kCFStringTransformMandarinLatin,NO);
    CFStringTransform((__bridge CFMutableStringRef)str,0,kCFStringTransformStripDiacritics,NO);
    //获取首字母   输出字母ASCII码 A-z 65~122 %hu打印asc码
    UniChar firstAlphabet = [str characterAtIndex:0];
    NSString *firstL = [NSString stringWithFormat:@"%c",firstAlphabet];
    return firstL.copy;
}
-(BOOL)isValidMobile{
    NSString * mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
-(CGSize)sizeForFont:(UIFont *)font size:(CGSize)size{
    if (!font) font = [UIFont systemFontOfSize:12];
    CGRect result = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:NULL];
    return result.size;
}
-(CGFloat)heightWithFont:(UIFont *)font{
    CGSize size = [self sizeForFont:font size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return size.height;
}
-(CGFloat)widthWithFont:(UIFont *)font{
    CGSize size = [self sizeForFont:font size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return size.width;
}
@end
