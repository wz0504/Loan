//
//  DYGMineViewController.m
//  dkcr
//
//  Created by FanXing on 2017/11/8.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGMineViewController.h"

#import "DYGMyHeaderView.h"
#import "DYGMineCell.h"
#import "LoginViewController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>


@interface DYGMineViewController ()<UINavigationControllerDelegate,DYGMineHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *titleArr;
@property(nonatomic,copy)NSString * user_id;
@property (nonatomic,strong) DYGMyHeaderView *headerView;


@end

@implementation DYGMineViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTabBarHeight);
    self.tableView.backgroundColor = KWhiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    
    self.headerView =[[DYGMyHeaderView alloc]init];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 304);
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithHexString:@"f2f2f2"];

    
}

-(void)loadData{
    NSDictionary * parmas = @{@"uid":self.user_id};
    [FXHttpTool postWithURL:@"getUserInfo" params:parmas sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
//        DYGMyInfoModel * model = [DYGMyInfoModel yy_modelWithDictionary:reslut[@"data"]];
//        self.headerView.model = model;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
    }];
}
//隐藏Nav
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYGMineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nCell"];
    if (!cell) {
        cell = [[DYGMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nCell"];
    }
    if (indexPath.row==0) {
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreenWidth-24, 48)
                                                        byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                              cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.frame  = CGRectMake(0, 0, kScreenWidth-24, 48);
        maskLayer.path   = maskPath.CGPath;
        cell.layer.mask  = maskLayer;
        [cell.layer setMasksToBounds:YES];
        cell.layer.masksToBounds = YES;
    }
    if (indexPath.row==3) {
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreenWidth-24, 48)
                                                        byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                              cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.frame  = CGRectMake(0, 0, kScreenWidth-24, 48);
        maskLayer.path   = maskPath.CGPath;
        cell.layer.mask  = maskLayer;
        [cell.layer setMasksToBounds:YES];
        cell.layer.masksToBounds = YES;
    }
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UserInfoManager removeAccountInfo];
    kAppWindow.rootViewController = [[RootNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
}



#pragma mark headeviewDelegate

-(void)collBtnClick{
//    DYGMyCollectViewController * vc = [[DYGMyCollectViewController alloc]init];
//    vc.title = @"我的收藏";
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)forumBtnClick{
//    DYGMyAskingViewController * vc = [[DYGMyAskingViewController alloc]init];
//    vc.title = @"我的帖子";
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)iconImgClick{
//    DYGSelfInfoViewController * vc = [[DYGSelfInfoViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}


-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"分享给好友",@"使用帮助",@"联系我们",@"更多"];
    }
    return _titleArr;
}



@end
