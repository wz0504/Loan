//
//  TextFieldCell.m
//  Loan
//
//  Created by FanXing on 2018/3/26.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "TextFieldCell.h"

@interface TextFieldCell()

//@property (nonatomic,strong) UIView *line; //线
@end
@implementation TextFieldCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(13);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //添加输入框
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-18);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    //添加线
//    [self.contentView addSubview:self.line];
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(13);
//        make.right.equalTo(self.contentView.mas_right);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.height.equalTo(@0.5);
//    }];
    
}



-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        //        _titleLabel.text = @"贷款金额";
        _titleLabel.font = kAdaptedFontSize(15);
        _titleLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.font = kAdaptedFontSize(15);
        
        //        _textField.placeholder = @"请输入金额";
       
    }
    return _textField;
}

//-(UIView *)line {
//    if (!_line) {
//        _line = [[UIView alloc] init];
//        _line.backgroundColor = CLineColor;
//
//    }
//    return _line;
//}

@end
