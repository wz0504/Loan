//
//  HomeController.m
//  Loan
//
//  Created by FanXing on 2018/2/8.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "HomeController.h"
#import "HomeHeaderView.h"
#import "LoanItemsCell.h"
#import "CollectionItemsView.h"
#import "ActivityTableCell.h"
#import "ApplyTableCell.h"
#import "HomeSectionHeader.h"

#import "LoanItemModel.h"

#import "LoanModel.h"

#import "LoanDetailModel.h"
#import "DYGDetailMessageViewController.h"
#import "DYGSelectViewController.h"
#import "QueryBillController.h"
@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,CollectionItemsViewDelegate,HomeSectionHeaderDelegate>
@property (nonatomic,strong) HomeHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *loanItemArray;
@property (nonatomic,strong) NSMutableArray *activityArray;
@property (nonatomic,strong) NSMutableArray *loanArray;
@property (nonatomic,strong) UserInfo *userInfo;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userInfo = [UserInfoManager getAccountInfo];
    [self createUI];
    
    [self headerRefresh];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)createUI {
    self.isHidenNaviBar = YES;
    self.StatusBarStyle = UIStatusBarStyleDefault;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, kStatusBarHeight, KScreenWidth, KScreenHeight -kStatusBarHeight- kTabBarHeight);
    self.tableView.backgroundColor = KWhiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = CLineColor;
    
    self.tableView.tableHeaderView = self.headerView;
    
}

#pragma mark ----- header refresh
-(void)headerRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self loadSuccessMessageData];
    }];
}

#pragma mark ----- loadMessage
-(void)loadSuccessMessageData {
    [FXHttpTool postWithURL:@"getLoanSuccess" params:nil sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        DLog(@"reslut:%@",reslut);
        if ([reslut[@"code"] intValue] == 200) {
            NSArray *array = reslut[@"data"];
            self.headerView.adArray = array;
        }
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
    }];
}
#pragma mark -----loadHomeData
-(void)loadData {

    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(dispatchGroup);
    
    [FXHttpTool postWithURL:@"homeData" params:nil sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        DLog(@"reslut:%@",reslut);
        if ([reslut[@"code"] intValue] == 200) {
            [self.loanItemArray removeAllObjects];
            [self.activityArray removeAllObjects];
            if ([reslut[@"module1"] count]>0) {
                for (NSDictionary *dict in reslut[@"module1"]) {
                    LoanItemModel *model = [LoanItemModel modelWithDictionary:dict];
                    [self.loanItemArray addObject:model];
                }
            }
            if ([reslut[@"module2"] count]>0) {
                for (NSDictionary *dict in reslut[@"module2"]) {
                    LoanItemModel *model = [LoanItemModel modelWithDictionary:dict];
                    [self.activityArray addObject:model];
                }
            }
            
            
            
        }else {
            [MBProgressHUD showInfoMessage:@"网络加载失败"];
        }
        dispatch_group_leave(dispatchGroup);
        
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    [FXHttpTool postWithURL:@"getHoleList" params:nil sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        DLog(@"reslut:%@",reslut);
        if ([reslut[@"code"] intValue] == 200) {
            [self.loanArray removeAllObjects];
            NSArray *array = reslut[@"data"];
            for (NSDictionary*dict in array) {
                LoanModel *model = [LoanModel modelWithDictionary:dict];
                [self.loanArray addObject:model];
            }
        }else {
            [MBProgressHUD showInfoMessage:@"网络加载失败"];
        }
        dispatch_group_leave(dispatchGroup);
        
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
        dispatch_group_leave(dispatchGroup);
        
    }];
    
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}



#pragma mark ------ UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return [self.activityArray count];
    }else if (section == 2){
        return [self.loanArray count];
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section== 0) {
        NSInteger count = self.loanItemArray.count;
        return (count/4+1+(count%4==0?-1:0))*100+8;
    }else if (indexPath.section == 1){
        return 164;
    }
    self.tableView.estimatedRowHeight = 80;
    return self.tableView.rowHeight = UITableViewAutomaticDimension;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        if (self.loanArray.count>0) {
            return 50;
        }
        return 0;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *viewIdentfier = @"HomeSectionHeader";
    if (section == 2) {
        HomeSectionHeader *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
        
        if(!sectionHeadView){
            sectionHeadView = [[HomeSectionHeader alloc] initWithReuseIdentifier:viewIdentfier];
        }
        sectionHeadView.titleLabel.text = @"热门口子";
        sectionHeadView.section = section;
        sectionHeadView.delegate = self;
        
        return sectionHeadView;
    }
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *rid=@"BankCardCell";
        LoanItemsCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[LoanItemsCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.dataSource = self.loanItemArray;
        cell.itemsView.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *rid=@"ActivityTableCell";
        ActivityTableCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[ActivityTableCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.activityArray[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){
        static NSString *rid=@"ApplyTableCell";
        ApplyTableCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[ApplyTableCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.loanArray[indexPath.row];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 2) {
        LoanModel *model = self.loanArray[indexPath.row];
        NSDictionary * parmas = @{@"uid":self.userInfo.user_id,@"hole_id":model.ID};
        cell.userInteractionEnabled = NO;
        [FXHttpTool postWithURL:@"getHolePart" params:parmas sucess:^(id json) {
            cell.userInteractionEnabled = YES;
            id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
            LoanDetailModel * model = [LoanDetailModel modelWithDictionary:reslut[@"data"]];
            DYGDetailMessageViewController * vc = [[DYGDetailMessageViewController alloc]init];
            vc.neesArray = model.material_str;
            vc.model = model;
            vc.title = model.title;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            cell.userInteractionEnabled = YES;
            DLog(@"error:%@",error);
        }];
    }
}

#pragma mark ---- CollectionItemsViewDelegate
-(void)collectionItemsView:(CollectionItemsView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath type:(CollectionItemsViewType)type{
    
//    DLog(@"%zd 分类:%zd",indexPath.item,type);
//
//    LoanItemModel *model = self.loanItemArray[indexPath.item];
//
//
//    if ([model.type intValue] == 5) { //闪刷
//        [self getShanShuaInfoWithModel:model];
//    }else if ([model.type intValue] == 1){
//        [self enterBtnDidSelected:4];
//    }else if ([model.type intValue] == 2){
//        [self enterBtnDidSelected:5];
//    }else if ([model.type intValue] == 3){
//        [self enterBtnDidSelected:6];
//    }else if ([model.type intValue] == 4){
//        [self enterBtnDidSelected:7];
//    }else if ([model.type intValue] == 0){ //h5
//
//    }
    QueryBillController*qery = [[QueryBillController alloc] init];
    [self.navigationController pushViewController:qery animated:YES];
}


#pragma mark ---- 闪刷
-(void)getShanShuaInfoWithModel:(LoanItemModel *)model {
    NSDictionary *parmas = @{@"uid":self.userInfo.user_id,@"phone":self.userInfo.phone};

    [FXHttpTool postWithURL:@"toPassPay" params:parmas sucess:^(id json) {
       
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        DLog(@"%@",reslut);
        if ([reslut[@"code"] integerValue] == 200) {
            NSString*urlString = NSStringFormat(@"%@?uid=%@",model.url,reslut[@"uid"]);
            RootWebViewController *web = [[RootWebViewController alloc] initWithUrl:urlString];
            [self.navigationController pushViewController:web animated:YES];
        }else {
            [MBProgressHUD showInfoMessage:@"网络加载失败"];
        }
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD showInfoMessage:@"网络加载失败"];
        DLog(@"error:%@",error);
    }];
}

#pragma mark  口子按钮点击事件
-(void)enterBtnDidSelected:(NSInteger)btn{
    
    NSDictionary * parmas = @{@"uid":self.userInfo.user_id};
    [FXHttpTool postWithURL:@"getHoleLable" params:parmas sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        DYGSelectViewController * vc = [[DYGSelectViewController alloc]init];
        vc.selecArr = reslut[@"data"];
        vc.btnId = btn;
        vc.title = @"口子大全";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"连接服务器失败,请检查网络连接";
        [hud hideAnimated:YES afterDelay:1];
    }];
    
}
#pragma mark ---- CardToolHeaderViewDelegate
-(void)headerView:(HomeSectionHeader *)headerView didClickedMoreActionInSection:(NSInteger)section {
    DLog(@"%zd",section);
    DLog(@"更多");
    if (section == 2) {
        NSDictionary * parmas = @{@"uid":self.userInfo.user_id};
        [FXHttpTool postWithURL:@"getHoleLable" params:parmas sucess:^(id json) {
            id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
            DYGSelectViewController * vc = [[DYGSelectViewController alloc]init];
            vc.selecArr = reslut[@"data"];
            
            vc.title = @"口子大全";
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"连接服务器失败,请检查网络连接";
            [hud hideAnimated:YES afterDelay:1];
        }];
    }
}
#pragma mark ---- lazyload
-(HomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 60)];
    }
    return _headerView;
}

-(NSMutableArray *)loanItemArray {
    if (!_loanItemArray) {
        _loanItemArray = [NSMutableArray array];
    }
    return _loanItemArray;
}

-(NSMutableArray *)activityArray {
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
    }
    return _activityArray;
}

-(NSMutableArray *)loanArray {
    if (!_loanArray) {
        _loanArray = [NSMutableArray array];
    }
    return _loanArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
