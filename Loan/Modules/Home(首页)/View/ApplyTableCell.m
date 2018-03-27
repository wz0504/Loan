//
//  ApplyTableCell.m
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "ApplyTableCell.h"
#import "LoanModel.h"
@interface ApplyTableCell()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * iconImage;
@property(nonatomic,strong)UILabel * numLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property (nonatomic,strong) UILabel *applyTitle;

@end
@implementation ApplyTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
        
    }
    return self;
}

-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"testIcon"];
        _iconImage.layer.cornerRadius =5;
        _iconImage.layer.masksToBounds = YES;
        //        [_iconImage sizeToFit];
    }
    return _iconImage;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.text = @"测试贷款";
        _titleLabel.font = kAdaptedFontSize(14);
        _titleLabel.textColor = [UIColor colorWithHexString:@"555555" ];
    }
    return _titleLabel;
}

-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
//        _numLabel.text = @"9999";
   
        _numLabel.textColor = [UIColor colorWithHexString:@"f45a16"];
        _numLabel.font = [UIFont systemFontOfSize:15];
    }
    return _numLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
//        _detailLabel.text = @"凭身份证2000-3000元,最快1小时放款";
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    }
    return _detailLabel;
}

-(UILabel *)applyTitle{
    if (!_applyTitle) {
        _applyTitle = [[UILabel alloc]init];
        _applyTitle.text = @"申请人数";
        _applyTitle.textColor = [UIColor colorWithHexString:@"909090"];
        _applyTitle.font = [UIFont systemFontOfSize:12];
    }
    return _applyTitle;
}

-(void)creatUI{
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.equalTo(@38);
        make.top.equalTo(self.contentView.mas_top).offset(17);
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(21);
        make.top.equalTo(self.contentView.mas_top).offset(17);
    }];
    [self.contentView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        //        make.top.equalTo(self.titleLabel.mas_bottom).offset(17);
        //        make.bottom.equalTo(self.contentView.mas_bottom).offset(-17);
        make.bottom.equalTo(self.iconImage.mas_bottom);
    }];
    [self.contentView addSubview:self.applyTitle];
    [self.applyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_right);
        make.centerY.equalTo(self.detailLabel.mas_centerY);
    }];
}

-(void)creatNormalCell{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


-(void)setModel:(LoanModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    //    self.detailLabel.text = [NSString stringWithFormat:@"凭身份证%@-%@元,最快%@小时放款",model.quota_s,model.quota_l,model.enter_time];
    if (model.abstr.length>0) {
        self.detailLabel.text = model.abstr;
    }else{
        self.detailLabel.text =@"";
    }
    //    NSString * str = [NSString stringWithFormat:@"%@人申请",model.apply_num];
    //    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
    //    NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",model.apply_num]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",model.apply_num]].length);
    //    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:bigRange];
    self.numLabel.text = model.apply_num;
}

@end
