//
//  CollectionItemsView.h
//  FlashPayBo
//
//  Created by FanXing on 2017/12/21.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CollectionItemsViewType) {
    CollectionItemsViewTypeBank = 1,       //银行
    CollectionItemsViewTypeTheme           //主题
};

@class CollectionItemsView;
@protocol CollectionItemsViewDelegate <NSObject>

@optional
-(void)collectionItemsView:(CollectionItemsView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath type:(CollectionItemsViewType)type;
@end
@interface CollectionItemsView : UIView
@property (nonatomic,weak) id<CollectionItemsViewDelegate> delegate;
@property (nonatomic,assign) CollectionItemsViewType type;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end
