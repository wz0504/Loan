//
//  DYGMyHeaderView.h
//  CS2.1
//
//  Created by Mr_Du on 2017/9/6.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol DYGMineHeaderViewDelegate <NSObject>

@optional

-(void)collBtnClick;

-(void)forumBtnClick;

-(void)iconImgClick;

@end




@interface DYGMyHeaderView : UIView

@property (nonatomic,strong) UIImageView *backImg;
@property (nonatomic,weak) id<DYGMineHeaderViewDelegate> delegate;

@end
