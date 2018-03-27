//
//  DYGDetailMessageViewController.h
//  CS2.1
//
//  Created by Mr_Du on 2017/8/8.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanDetailModel;
@interface DYGDetailMessageViewController : RootViewController

@property(nonatomic,copy)NSString * hole_id;

@property (nonatomic,strong) LoanDetailModel *model;

@property(nonatomic,strong)NSArray *neesArray;
@end
