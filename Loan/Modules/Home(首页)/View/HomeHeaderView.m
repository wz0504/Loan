//
//  HomeHeaderView.m
//  Loan
//
//  Created by FanXing on 2018/2/8.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong) SDCycleScrollView *messageView;
@end
@implementation HomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    [self addSubview:self.logoImageView];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.centerY.equalTo(self.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [self addSubview:self.messageView];
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(2);
        make.left.equalTo(self.logoImageView.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.mas_equalTo(45);
    }];
    
    //添加底线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"f1f2f3"];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.mas_equalTo(0.5);
    }];
    
}

-(void)setAdArray:(NSArray *)adArray {
    _adArray = adArray;
    self.messageView.titlesGroup = adArray;
}
#pragma mark ---lazyload
-(UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"message_logo"];
    }
    return _logoImageView;
}
-(SDCycleScrollView *)messageView {
    if (!_messageView) {
        _messageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _messageView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _messageView.onlyDisplayText = YES;
        _messageView.backgroundColor = KWhiteColor;
        [_messageView disableScrollGesture];
    }
    return _messageView;
}

@end
