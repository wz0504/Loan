//
//  HomeSectionHeader.h
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeSectionHeader;
@protocol HomeSectionHeaderDelegate <NSObject>

-(void)headerView:(HomeSectionHeader *)headerView didClickedMoreActionInSection:(NSInteger)section;

@end
@interface HomeSectionHeader : UITableViewHeaderFooterView
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *moreBtn;

@property (nonatomic,assign) NSInteger section;

@property (nonatomic,weak) id<HomeSectionHeaderDelegate> delegate;

@end
