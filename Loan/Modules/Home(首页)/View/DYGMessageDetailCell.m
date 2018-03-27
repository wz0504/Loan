//
//  DYGMessageDetailCell.m
//  CS2.1
//
//  Created by Mr_Du on 2017/9/1.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGMessageDetailCell.h"

@interface DYGMessageDetailCell()

@property(nonatomic,strong)UIImageView * iconImg;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong) UILabel *successRate;
@property (nonatomic,strong) UILabel *maxMoney;
@property (nonatomic,strong) UILabel *maxLabel;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *apply;
@property (nonatomic,strong) UILabel *canMoneyNum;
@property (nonatomic,strong) UILabel *rate;
@property (nonatomic,strong) UILabel *monthRate;
@property (nonatomic,strong) UILabel *fastTime;

@end

@implementation DYGMessageDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(12);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.centerY.equalTo(self.iconImg);
    }];
    [self.contentView addSubview:self.successRate];
    [self.successRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-50);
        make.centerY.equalTo(self.title.mas_centerY);
    }];
    [self.contentView addSubview:self.rate];
    [self.rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.successRate.mas_right).offset(2);
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.successRate);
    }];
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-16);
        make.left.equalTo(self.contentView).offset(116);
        make.size.mas_equalTo(CGSizeMake(1, 69));
    }];
    
    [self.contentView addSubview:self.maxLabel];
    [self.maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_left).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-30);
    }];
    [self.contentView addSubview:self.maxMoney];
    [self.maxMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.maxLabel);
        make.bottom.equalTo(self.maxLabel.mas_top).offset(-12);
    }];
    [self.contentView addSubview:self.monthRate];
    [self.monthRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-18);
        make.left.equalTo(self.line.mas_right).offset(12);
    }];
    [self.contentView addSubview:self.fastTime];
    [self.fastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.monthRate);
        make.left.equalTo(self.monthRate.mas_right).offset(12);
    }];
    [self.contentView addSubview:self.canMoneyNum];
    [self.canMoneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.monthRate.mas_top).offset(-14);
        make.left.equalTo(self.monthRate);
    }];
    [self.contentView addSubview:self.apply];
    [self.apply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canMoneyNum);
        make.bottom.equalTo(self.canMoneyNum.mas_top).offset(-14);
    }];
}

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.layer.cornerRadius = 5;
        _iconImg.layer.masksToBounds = YES;
    }
    return _iconImg;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"口子超人";
        _title.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _title.font =[UIFont systemFontOfSize:14];
    }
    return _title;
}
-(UILabel *)successRate{
    if (!_successRate) {
        _successRate = [[UILabel alloc]init];
        _successRate.text =@"通过率";
        _successRate.font = [UIFont systemFontOfSize:12];
        _successRate.textColor = [UIColor colorWithHexString:@"909090" alap:1];
    }
    return _successRate;
}
-(UILabel *)rate{
    if (!_rate) {
        _rate = [[UILabel alloc]init];
        _rate.text = @"28%";
        _rate.font = [UIFont systemFontOfSize:12];
        _rate.textAlignment = NSTextAlignmentLeft;
        _rate.textColor = [UIColor colorWithHexString:@"ff9b2f" alap:1];
    }
    return _rate;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor =[UIColor colorWithHexString:@"eeeeee" alap:1];
    }
    return _line;
}

-(UILabel *)maxMoney{
    if (!_maxMoney) {
        _maxMoney =[[UILabel alloc]init];
        _maxMoney.text = @"3万";
        _maxMoney.textColor =[UIColor colorWithHexString:@"ff9b2f" alap:1];
        _maxMoney.font = [UIFont systemFontOfSize:12];
    }
    return _maxMoney;
}
-(UILabel *)maxLabel{
    if (!_maxLabel) {
        _maxLabel = [[UILabel alloc]init];
        _maxLabel.text = @"最高额度";
        _maxLabel.textColor =[UIColor colorWithHexString:@"909090" alap:1];
        _maxLabel.font = [UIFont systemFontOfSize:11];
    }
    return _maxLabel;
}
-(UILabel *)apply{
    if (!_apply) {
        _apply = [[UILabel alloc]init];
        _apply.text =@"申请人数91231人";
        _apply.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _apply.font = [UIFont systemFontOfSize:12];
    }
    return _apply;
}

-(UILabel *)canMoneyNum{
    if (!_canMoneyNum) {
        _canMoneyNum = [[UILabel alloc]init];
        _canMoneyNum.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _canMoneyNum.text = @"凭身份证可贷2000-30000元";
        _canMoneyNum.font = [UIFont systemFontOfSize:12];
    }
    return _canMoneyNum;
}

-(UILabel *)monthRate{
    if (!_monthRate) {
        _monthRate = [[UILabel alloc]init];
        _monthRate.text = @"参考月息1.3%";
        _monthRate.textColor = [UIColor colorWithHexString:@"1da9ff" alap:1];
        _monthRate.layer.borderColor = [[UIColor colorWithHexString:@"1da9ff" alap:1] CGColor];
        _monthRate.layer.borderWidth = 0.5;
        _monthRate.font = [UIFont systemFontOfSize:11];
    }
    return _monthRate;
}
-(UILabel *)fastTime{
    if (!_fastTime) {
        _fastTime =[[UILabel alloc]init];
        _fastTime.textColor = [UIColor colorWithHexString:@"1da9ff" alap:1];
        _fastTime.text =@"最快3分钟下款";
        _fastTime.layer.borderColor = [[UIColor colorWithHexString:@"1da9ff" alap:1] CGColor];
        _fastTime.layer.borderWidth = 0.5;
        _fastTime.font = [UIFont systemFontOfSize:11];
    }
    return _fastTime;
}


-(void)setModel:(LoanDetailModel *)model{
    _model = model;
    self.title.text = model.title;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    self.apply.text = [NSString stringWithFormat:@"申请人数%@人",model.apply_num];
    self.canMoneyNum.text = [NSString stringWithFormat:@"凭身份证可贷%@-%@元",self.model.quota_s,self.model.quota_l];
    self.monthRate.text = [NSString stringWithFormat:@"参考月息%@%%",self.model.monthly_s];
    self.fastTime.text = [NSString stringWithFormat:@"最快%@小时下款",self.model.enter_time];
    
    NSInteger mo = self.model.quota_l.integerValue;
    NSString * str1 =@"";
    CGFloat x = (CGFloat)mo/10000;
    if (x>1) {
        str1 = [NSString stringWithFormat:@"%.1f万",x];
    }else{
        str1 = [NSString stringWithFormat:@"%@元",self.model.quota_l];
    }
    NSMutableAttributedString * att1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange bigRange1 = NSMakeRange([[att1 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.quota_l]].location, [[att1 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.quota_l]].length);
    
    NSRange bigRange2 = NSMakeRange([[att1 string]rangeOfString:[NSString stringWithFormat:@"%.1f",x]].location, [[att1 string]rangeOfString:[NSString stringWithFormat:@"%.1f",x]].length);
    
    [att1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:bigRange1];
    [att1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:bigRange2];
    self.maxMoney.attributedText = att1;
    self.rate.text=[NSString stringWithFormat:@"%@%%",self.model.succrate_l];
}


@end
