//
//  CollectionItemsCell.m
//  CashManager
//
//  Created by FanXing on 2018/1/17.
//  CokAdaptedHeightright © 2018年 FanXing. All rights reserved.
//

#import "CollectionItemsCell.h"
#import "LoanItemModel.h"


@interface CollectionItemsCell()

@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@end
@implementation CollectionItemsCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    [self.contentView addSubview:self.coverImageView];
//    self.coverImageView.backgroundColor = [UIColor redColor];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kAdaptedHeight(12));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.equalTo(@(CGSizeMake(kAdaptedWidth(50), kAdaptedWidth(50))));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView.mas_bottom).offset(kAdaptedHeight(10));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}

-(void)setModel:(LoanItemModel *)model {
    _model = model;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    
    self.titleLabel.text = model.entrance;
}
#pragma mark ---------lazy load
-(UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        //        _coverImageView.backgroundColor = [UIColor greenColor];
    }
    return _coverImageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"404040"];
        _titleLabel.font = kAdaptedFontSize(kAdaptedWidth(12));
//        _titleLabel.text = @"四月天";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}
@end
