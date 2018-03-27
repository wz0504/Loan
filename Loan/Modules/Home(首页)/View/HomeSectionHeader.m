//
//  HomeSectionHeader.m
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "HomeSectionHeader.h"

@implementation HomeSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createUI];//表示初始化方法
    }
    
    return self;
}

-(void)createUI {
    self.contentView.backgroundColor = KWhiteColor;
    
    //添加左视图
    UIImageView *logoImgV = [[UIImageView alloc] init];
    logoImgV.image = [UIImage imageNamed:@"buoy"];
    [self.contentView addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //添加标题
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImgV.mas_right).offset(6);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //添加更多按钮
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //添加分割线
    UIView *bottomLine = [UIView new];
    [self.contentView addSubview:bottomLine];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, 0.5));
    }];
    
}

-(void)moreBtnAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(headerView:didClickedMoreActionInSection:)]) {
        [self.delegate headerView:self didClickedMoreActionInSection:self.section];
    }
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor colorWithHexString:@"404040"];
        _titleLabel.text = @"热门银行";
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"696969"] forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = kAdaptedFontSize(15);
        [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn sizeToFit];
    }
    return _moreBtn;
}

@end
