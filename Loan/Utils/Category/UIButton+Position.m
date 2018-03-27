//
//  UIButton+Position.m
//  beautyC
//
//  Created by 象萌cc002 on 2017/6/23.
//  Copyright © 2017年 象萌cc002. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton (Position)

- (void)xm_setImagePosition:(XMImagePosition)postion titleFont:(UIFont *)font spacing:(CGFloat)spacing {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;

    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: font}].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: font}].height;
    //image中心移动的x距离
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;
    //image中心移动的y距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;
    //label中心移动的x距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;
    //label中心移动的y距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;
    
    switch (postion) {
        case XMImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case XMImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            break;
            
        case XMImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
            
        case XMImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
            
        default:
            break;
    }
}

@end
