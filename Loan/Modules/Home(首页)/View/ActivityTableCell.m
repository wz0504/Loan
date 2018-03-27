//
//  ActivityTableCell.m
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "ActivityTableCell.h"
#import "ActivityModel.h"
@interface ActivityTableCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *coverImageView;
@end
@implementation ActivityTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI {
    self.contentView.backgroundColor = KWhiteColor;
    //1.添加图标
    UIImageView *logoImgV = [[UIImageView alloc] init];
    logoImgV.image = [UIImage imageNamed:@"buoy"];
    [self.contentView addSubview:logoImgV];
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImgV.mas_right).offset(9);
        make.centerY.equalTo(logoImgV.mas_centerY);
    }];
    
    [self.contentView addSubview:self.coverImageView];
//    self.coverImageView.backgroundColor = [UIColor redColor];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, 110));
    }];
    
    //添加底部
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = CLineColor;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(KScreenWidth);
    }];
}

-(void)setModel:(ActivityModel *)model {
    _model = model;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    
    self.titleLabel.text = model.entrance;
    
}

#pragma mark ---- lazyload
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"404040"];
        [_titleLabel sizeToFit];
//        _titleLabel.text = @"新用户专属活动";
    }
    return _titleLabel;
}

-(UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}
@end
