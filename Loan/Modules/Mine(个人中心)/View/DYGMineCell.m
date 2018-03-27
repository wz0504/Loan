//
//  DYGMineCell.m
//  CS2.1
//
//  Created by Mr_Du on 2017/9/6.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGMineCell.h"


@interface DYGMineCell()

//@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * subImg;

@end

@implementation DYGMineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.contentView addSubview:self.subImg];
    [self.subImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

-(void)setFrame:(CGRect)frame {
    frame.size.width-=24;
    frame.origin.x +=13;
    [super setFrame:frame];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"555555"];
        _titleLabel.font =[UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UIImageView *)subImg{
    if (!_subImg) {
        _subImg =[[UIImageView alloc]init];
        _subImg.image = [UIImage imageNamed:@"rigthrow"];
        [_subImg sizeToFit];
    }
    return _subImg;
}


@end
