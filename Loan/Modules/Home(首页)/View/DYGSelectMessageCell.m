//
//  DYGSelectMessageCell.m
//  CS2.1
//
//  Created by Mr_Du on 2017/8/7.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGSelectMessageCell.h"

@interface DYGSelectMessageCell()

@property(nonatomic,strong)UIImageView * iconImg;
@property(nonatomic,strong)UILabel * titleLabel;
//申请人数
@property(nonatomic,strong)UILabel * applyNumTitle;
@property(nonatomic,strong)UILabel * applyNum;
//最快下款
@property(nonatomic,strong)UILabel * fastMoneyTitle;
@property(nonatomic,strong)UILabel * fastMoneyNum;

@property(nonatomic,strong)UILabel * moneyLbale;
//通过率
@property(nonatomic,strong)UILabel * passRateTitle;
@property(nonatomic,strong)UILabel * passRateNum;
//参考月息
@property(nonatomic,strong)UILabel * monthRateTitle;
@property(nonatomic,strong)UILabel * monthRateNum;

@property(nonatomic,strong)UILabel * messageLabel;


@end

@implementation DYGSelectMessageCell

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.image = [UIImage imageNamed:@"AppIcon"];
        [_iconImg sizeToFit];
    }
    return _iconImg;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"口子超人";
        _titleLabel.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

-(UILabel *)applyNumTitle{
    if (!_applyNumTitle) {
        _applyNumTitle = [[UILabel alloc]init];
        _applyNumTitle.text = @"申请人数";
        _applyNumTitle.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _applyNumTitle.font = [UIFont systemFontOfSize:12];
    }
    return _applyNumTitle;
}

-(UILabel *)applyNum{
    if (!_applyNum) {
        _applyNum = [[UILabel alloc]init];
        _applyNum.text = @"4人";
        _applyNum.textColor = [UIColor colorWithHexString:@"f45a16" alap:1];
        _applyNum.font = [UIFont systemFontOfSize:12];
    }
    return _applyNum;
}
-(UILabel *)fastMoneyTitle{
    if (!_fastMoneyTitle) {
        _fastMoneyTitle = [[UILabel alloc]init];
        _fastMoneyTitle.text = @"最快下款";
        _fastMoneyTitle.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _fastMoneyTitle.font = [UIFont systemFontOfSize:12];
    }
    return _fastMoneyTitle;
}

-(UILabel *)fastMoneyNum{
    if (!_fastMoneyNum) {
        _fastMoneyNum = [[UILabel alloc]init];
        _fastMoneyNum.text = @"1小时";
        _fastMoneyNum.textColor = [UIColor colorWithHexString:@"f45a16" alap:1];
        _fastMoneyNum.font = [UIFont systemFontOfSize:12];
    }
    return _fastMoneyNum;
}

-(UILabel *)moneyLbale{
    if (!_moneyLbale) {
        _moneyLbale = [[UILabel alloc]init];
        _moneyLbale.text = @"0.1-1万";
//        万 14
        _moneyLbale.textColor = [UIColor colorWithHexString:@"f45a16" alap:1];
        _moneyLbale.font = [UIFont systemFontOfSize:14];
    }
    return _moneyLbale;
}

-(UILabel *)passRateTitle{
    if (!_passRateTitle) {
        _passRateTitle = [[UILabel alloc]init];
        _passRateTitle.text = @"通过率";
        _passRateTitle.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _passRateTitle.font = [UIFont systemFontOfSize:12];
    }
    return _passRateTitle;
}

-(UILabel *)passRateNum{
    if (!_passRateNum) {
        _passRateNum = [[UILabel alloc]init];
        _passRateNum.text = @"98%";
        _passRateNum.textColor = [UIColor colorWithHexString:@"f45a16" alap:1];
        _passRateNum.font = [UIFont systemFontOfSize:12];
    }
    return _passRateNum;
}

-(UILabel *)monthRateTitle{
    if (!_monthRateTitle) {
        _monthRateTitle = [[UILabel alloc]init];
        _monthRateTitle.text = @"参考月息";
        _monthRateTitle.textColor = [UIColor colorWithHexString:@"555555" alap:1];
        _monthRateTitle.font = [UIFont systemFontOfSize:12];
    }
    return _monthRateTitle;
}

-(UILabel *)monthRateNum{
    if (!_monthRateNum) {
        _monthRateNum = [[UILabel alloc]init];
        _monthRateNum.text = @"1.0%";
        _monthRateNum.font = [UIFont systemFontOfSize:12];
        _monthRateNum.textColor = [UIColor colorWithHexString:@"f45a16" alap:1];
    }
    return _monthRateNum;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"卡友交流社区";
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090" alap:1];
        _messageLabel.font = [UIFont systemFontOfSize:12];
    }
    return _messageLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self creatUI]; 
    }
    return self;
}


-(void)creatUI{
    
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.width.height.equalTo(@(38));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(15);
        make.top.equalTo(self.iconImg.mas_top);
    }];
    
    [self.contentView addSubview:self.applyNumTitle];
    [self.applyNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
    }];
    [self.contentView addSubview:self.applyNum];
    [self.applyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applyNumTitle.mas_right).offset(12);
//        make.bottom.equalTo(self.applyNumTitle.mas_bottom);
        make.centerY.equalTo(self.applyNumTitle.mas_centerY);
    }];
    [self.contentView addSubview:self.fastMoneyTitle];
    [self.fastMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applyNumTitle.mas_left);
        make.top.equalTo(self.applyNumTitle.mas_bottom).offset(14);
    }];
    
    [self.contentView addSubview:self.fastMoneyNum];
    [self.fastMoneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fastMoneyTitle.mas_right).offset(12);
//        make.bottom.equalTo(self.fastMoneyTitle.mas_bottom);
        make.centerY.equalTo(self.fastMoneyTitle.mas_centerY);
    }];
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fastMoneyTitle.mas_left);
        make.top.equalTo(self.fastMoneyTitle.mas_bottom).offset(14);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-17);
    }];
    
    [self.contentView addSubview:self.monthRateNum];
    [self.monthRateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-22);
//        make.bottom.equalTo(self.fastMoneyTitle.mas_bottom);
        make.centerY.equalTo(self.fastMoneyTitle.mas_centerY);
    }];
    
    [self.contentView addSubview:self.monthRateTitle];
    [self.monthRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.monthRateNum.mas_left).offset(-12);
//        make.bottom.equalTo(self.fastMoneyTitle.mas_bottom);
        make.centerY.equalTo(self.monthRateNum.mas_centerY);
    }];
    
    [self.contentView addSubview:self.passRateTitle];
    [self.passRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthRateTitle.mas_left);
//        make.bottom.equalTo(self.monthRateTitle.mas_top).offset(-14);
        make.centerY.equalTo(self.applyNum.mas_centerY);
    }];
    
    [self.contentView addSubview:self.passRateNum];
    [self.passRateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passRateTitle.mas_right).offset(12);
//        make.bottom.equalTo(self.passRateTitle.mas_bottom);
        make.centerY.equalTo(self.passRateTitle.mas_centerY);
    }];
    [self.contentView addSubview:self.moneyLbale];
    [self.moneyLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passRateTitle.mas_left);
//        make.bottom.equalTo(self.titleLabel.mas_bottom);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    
}

-(void)setModel:(LoanDetailModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    if (model.abstr.length>0) {
        self.messageLabel.text = model.abstr;
    }else{
        self.messageLabel.text =@"";
    }
//    9万人
    NSString * str = [NSString stringWithFormat:@"%@人",model.apply_num];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",model.apply_num]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",model.apply_num]].length);
//    18
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:bigRange];
    self.applyNum.attributedText = att;
    
//    0.2-3万
    NSInteger mo = self.model.quota_l.integerValue;
    NSString * str1 =@"";
    CGFloat x = (CGFloat)mo/10000;
    if (x>1) {
        str1 = [NSString stringWithFormat:@"%@-%.1f万",self.model.quota_s,x];
    }else{
        str1 = [NSString stringWithFormat:@"%@-%@元",self.model.quota_s,self.model.quota_l];
    }
    NSMutableAttributedString * att1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange bigRange1 = NSMakeRange([[att1 string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.model.quota_s,self.model.quota_l]].location, [[att1 string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.model.quota_s,self.model.quota_l]].length);
    [att1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:bigRange1];
    self.moneyLbale.attributedText = att1;
    
//   3分钟
    NSString * str2 = [NSString stringWithFormat:@"%@小时",self.model.enter_time];
    NSMutableAttributedString * att2 = [[NSMutableAttributedString alloc]initWithString:str2];
    NSRange bigRange2 = NSMakeRange([[att2 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.enter_time]].location, [[att2 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.enter_time]].length);
//    18
    [att2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:bigRange2];
    self.fastMoneyNum.attributedText = att2;
    
//    通过率
    NSString * str3 = [NSString stringWithFormat:@"%@%%",self.model.succrate_l];
    NSMutableAttributedString * att3 = [[NSMutableAttributedString alloc]initWithString:str3];
    NSRange bigRange3 = NSMakeRange([[att3 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.succrate_l]].location, [[att3 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.succrate_l]].length);
//    18
    [att3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:bigRange3];
    self.passRateNum.attributedText = att3;
    
//    参考月息
    NSString * str4 = [NSString stringWithFormat:@"%@%%",self.model.monthly_s];
    NSMutableAttributedString * att4 = [[NSMutableAttributedString alloc]initWithString:str4];
    NSRange bigRange4 = NSMakeRange([[att4 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.monthly_s]].location, [[att4 string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.monthly_s]].length);
//    18
    [att4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:bigRange4];
    self.monthRateNum.attributedText = att4;
}

@end










