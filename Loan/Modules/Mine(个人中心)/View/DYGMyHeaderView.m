
//
//  DYGMyHeaderView.m
//  CS2.1
//
//  Created by Mr_Du on 2017/9/6.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGMyHeaderView.h"

@interface DYGMyHeaderView()

@property(nonatomic,strong)UIImageView * iconImg;
//@property (nonatomic,strong) UIImageView *backImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *perfectRate;
@property (nonatomic,strong) UILabel *subLabel;
@property (nonatomic,strong) UIImageView * frontView;
@property (nonatomic,strong) UILabel *collNum;
@property (nonatomic,strong) UIButton * collBtn;
@property (nonatomic,strong) UILabel *collLabel;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *forumNum;
@property (nonatomic,strong) UIButton *forumBtn;
@property (nonatomic,strong) UILabel *forumLabel;

@end


@implementation DYGMyHeaderView


-(instancetype)init{
    if (self = [super init]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    [self addSubview:self.backImg];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 252));
    }];
    [self addSubview:self.frontView];
    [self.frontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(356, 121));
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@121);
    }];
    [self.backImg addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImg.mas_centerX);
        make.top.equalTo(self.backImg.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    [self.backImg addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconImg.mas_centerX);
        make.top.equalTo(self.iconImg.mas_bottom).offset(7);
    }];
    
    [self.backImg addSubview:self.perfectRate];
    [self.perfectRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
    [self.backImg addSubview:self.subLabel];
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.perfectRate.mas_bottom).offset(5);
    }];
    
    
    [self.frontView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.frontView.mas_centerX);
        make.centerY.equalTo(self.frontView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 77));
    }];
//    208 48
    [self.frontView addSubview:self.collBtn];
    CGFloat left = (CGFloat)42/750;
    CGFloat right =(CGFloat)38/750;
    [self.collBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.frontView.mas_left).offset(kScreenWidth*left);
        make.right.equalTo(self.line.mas_left).offset(-kScreenWidth*right);
//        make.centerX.equalTo(self.line.mas_left).offset(-88.5);
        make.centerY.equalTo(self.frontView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(104, 24));
        make.height.equalTo(@24);
    }];
    [self.frontView addSubview:self.collNum];
    [self.collNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontView.mas_top).offset(16);
        make.centerX.equalTo(self.collBtn.mas_centerX);
    }];
    
    [self.frontView addSubview:self.collLabel];
    [self.collLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.collBtn.mas_centerX);
        make.top.equalTo(self.collBtn.mas_bottom).offset(13);
    }];
    
    [self.frontView addSubview:self.forumBtn];
    [self.forumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.frontView.mas_right).offset(-42);
//        make.centerX.equalTo(self.line.mas_right).offset(88.5);
        make.right.equalTo(self.frontView.mas_right).offset(-kScreenWidth*left);
        make.left.equalTo(self.line.mas_right).offset(kScreenWidth*right);
        make.centerY.equalTo(self.frontView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(104, 24));
        make.height.equalTo(@24);
    }];
    
    [self.frontView addSubview:self.forumNum];
    [self.forumNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontView.mas_top).offset(16);
        make.centerX.equalTo(self.forumBtn.mas_centerX);
    }];
    [self.frontView addSubview:self.forumLabel];
    [self.forumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forumBtn.mas_bottom).offset(13);
        make.centerX.equalTo(self.forumBtn.mas_centerX);
    }];
}

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]init];
        _backImg.image = [UIImage imageNamed:@"bg"];
        _backImg.userInteractionEnabled = YES;
    }
    return _backImg;
}
-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
//        _iconImg.backgroundColor=[UIColor redColor];
        _iconImg.layer.cornerRadius =32;
        _iconImg.layer.masksToBounds = YES;
        _iconImg.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterSetting)];
        [_iconImg addGestureRecognizer:tap];
        [_iconImg sizeToFit];
    }
    return _iconImg;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

-(UILabel *)perfectRate{
    if (!_perfectRate) {
        _perfectRate = [[UILabel alloc]init];
        _perfectRate.textColor = [UIColor whiteColor];
        _perfectRate.font = [UIFont systemFontOfSize:12];
        _perfectRate.textAlignment = NSTextAlignmentCenter;
    }
    return _perfectRate;
}

-(UILabel *)subLabel{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc]init];
        _subLabel.textColor = [UIColor whiteColor];
        _subLabel.font = [UIFont systemFontOfSize:12];
        _subLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subLabel;
}
-(UIImageView *)frontView{
    if (!_frontView) {
        _frontView = [[UIImageView alloc]init];
        _frontView.userInteractionEnabled = YES;
        _frontView.image = [UIImage imageNamed:@"part1"];
        _frontView.userInteractionEnabled = YES;
    }
    return _frontView;
}

-(UILabel *)collNum{
    if (!_collNum) {
        _collNum = [[UILabel alloc]init];
        _collNum.textColor = [UIColor colorWithHexString:@"f28943"];
        _collNum.font = [UIFont systemFontOfSize:28];
    }
    return _collNum;
}

-(UIButton *)collBtn{
    if (!_collBtn) {
        _collBtn = [[UIButton alloc]init];
        [_collBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
        _collBtn.imageEdgeInsets =UIEdgeInsetsMake(0, -9, 0, 0);
        [_collBtn setImage:[UIImage imageNamed:@"loan"] forState:UIControlStateNormal];
        _collBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_collBtn setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
        [_collBtn addTarget:self action:@selector(collBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collBtn;
}

-(UILabel *)collLabel{
    if (!_collLabel) {
        _collLabel = [[UILabel alloc]init];
        _collLabel.text = @"已收藏的口子和帖子";
        _collLabel.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        _collLabel.font = [UIFont systemFontOfSize:12];
    }
    return _collLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return _line;
}

-(UILabel *)forumNum{
    if (!_forumNum) {
        _forumNum = [[UILabel alloc]init];
        _forumNum.textColor = [UIColor colorWithHexString:@"fe8943"];
        _forumNum.font = [UIFont systemFontOfSize:28];
    }
    return _forumNum;
}

-(UIButton *)forumBtn{
    if (!_forumBtn) {
        _forumBtn = [[UIButton alloc]init];
        [_forumBtn setTitle:@"我的申请" forState:UIControlStateNormal];
        _forumBtn.imageEdgeInsets =UIEdgeInsetsMake(0, -9, 0, 0);
        [_forumBtn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
        _forumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_forumBtn setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
        [_forumBtn addTarget:self action:@selector(forumBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forumBtn;
}

-(UILabel *)forumLabel{
    if (!_forumLabel) {
        _forumLabel = [[UILabel alloc]init];
        _forumLabel.text = @"已申请和批款的记录";
        _forumLabel.textColor = [UIColor colorWithHexString:@"a0a0a0"];
        _forumLabel.font = [UIFont systemFontOfSize:12];
    }
    return _forumLabel;
}



-(void)collBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(collBtnClick)]) {
        [self.delegate collBtnClick];
    }
}
-(void)forumBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(forumBtnClick)]) {
        [self.delegate forumBtnClick];
    }
}

-(void)enterSetting{
    if ([self.delegate respondsToSelector:@selector(iconImgClick)]) {
        [self.delegate iconImgClick];
    }
}


@end










