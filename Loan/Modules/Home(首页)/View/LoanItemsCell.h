//
//  LoanItemsCell.h
//  Loan
//
//  Created by FanXing on 2018/2/22.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionItemsView;
@interface LoanItemsCell : UITableViewCell
@property (nonatomic,strong) CollectionItemsView *itemsView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end
