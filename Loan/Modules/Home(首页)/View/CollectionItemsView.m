//
//  CollectionItemsView.m
//  FlashPayBo
//
//  Created by FanXing on 2017/12/21.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "CollectionItemsView.h"
#import "CollectionItemsCell.h"

@interface CollectionItemsView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *themeIamgeArray;
@end
@implementation CollectionItemsView

-(instancetype)init{
    if (self = [super init]) {
        [self creatUI];
        self.backgroundColor = KWhiteColor;
        self.type = CollectionItemsViewTypeBank;//默认是热门银行样式
    }
    return self;
}

-(void)creatUI {
    [self addSubview:self.collectView];
    
}

-(void)layoutSubviews {
    self.collectView.frame = self.bounds;
}

-(void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.collectView reloadData];
}
#pragma mark -----UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionItemsCell" forIndexPath:indexPath];
//    cell.titleLabel.text = @"小额极速贷";
    cell.model = self.dataSource[indexPath.item];
    return cell;
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  CGSizeMake(CGRectGetWidth(self.frame)/4,CGRectGetHeight(self.frame)/(self.dataSource.count/4+1+(self.dataSource.count%4==0?-1:0)));
    
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0,0);//（上、左、下、右）
}

#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(collectionItemsView:didSelectItemAtIndexPath:type:)]) {
        [self.delegate collectionItemsView:self didSelectItemAtIndexPath:indexPath type:self.type];
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark ----lazyload
-(UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectView.backgroundColor = KWhiteColor;;
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[CollectionItemsCell class] forCellWithReuseIdentifier:@"CollectionItemsCell"];
    }
    return _collectView;
}

//-(NSArray *)titleArray {
//    if (!_titleArray) {
//        _titleArray = @[@"订单查询",@"分润明细",@"员工管理",@"商户版",@"我的费率",@"我要升级",@"新手入门",@"我的消息"];
//    }
//    return _titleArray;
//}
//
//-(NSArray *)imageArray {
//    if (!_imageArray) {
//        _imageArray = @[@"home_look",@"home_money",@"home_worker",@"home_merchant",@"home_rate",@"home_upgrade",@"home_newer",@"home_message"];
//    }
//    return _imageArray;
//}

-(NSArray *)themeIamgeArray {
    if (!_themeIamgeArray) {
        _themeIamgeArray = @[@"creditCard_newer",@"creditCard_quick",@"creditCard_maxMoney",@"creditCard_food"];
    }
    return _themeIamgeArray;
}

@end
