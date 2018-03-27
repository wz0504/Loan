//
//  LoanItemsCell.m
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "LoanItemsCell.h"
#import "CollectionItemsView.h"
@interface LoanItemsCell()

@end
@implementation LoanItemsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI {
    self.contentView.backgroundColor = CLineColor;
    //1.添加CollectionItemsView
    self.itemsView = [[CollectionItemsView alloc] init];
    [self.contentView addSubview:self.itemsView];
    
}

-(void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    self.itemsView.frame = CGRectMake(0, 0, kScreenWidth, (dataSource.count/4+1+(dataSource.count%4==0?-1:0))*100);
    self.itemsView.dataSource = dataSource;
}


@end
