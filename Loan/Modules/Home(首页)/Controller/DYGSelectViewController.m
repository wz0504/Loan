//
//  DYGSelectViewController.m
//  CS2.1
//
//  Created by Mr_Du on 2017/8/7.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGSelectViewController.h"
#import "DYGSelectMessageCell.h"
#import "DYGDetailMessageViewController.h"
#import "LoanDetailModel.h"
#import "DYGMessageDetailCell.h"

#define DYGRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface DYGSelectViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView * typeView;
@property(nonatomic,strong)UIView * subTypeView;
@property(nonatomic,strong)UITableView * tableView;
//数据数组
@property (nonatomic,strong) NSMutableArray * dataArry;

//默认请求参数值
//开始下标
@property (nonatomic,assign) NSInteger index;
//加载数量
@property (nonatomic,assign) NSInteger num;
//排序类型 0：默认；1：通过率高；2：下款最快；3：利率最低
@property (nonatomic,assign) NSInteger sort;
//金额范围
@property(nonatomic,copy)NSString * start_money;
@property(nonatomic,copy)NSString * end_money;


//title 数组
@property (nonatomic,strong) NSMutableArray *titleArr;

//金额数组映射数据数组
@property (nonatomic,strong) NSArray *moneyArr;

@property(nonatomic,strong)UIButton * moneyBtn;
@property(nonatomic,strong)UIButton * typeBtn;

//下方
@property(nonatomic,strong)UIButton * tempBtn;

//内部
@property(nonatomic,strong)UIButton * ntempBtn;

@property(nonatomic,strong)UIView * line1;
@property(nonatomic,strong)UIView * line2;

//popview
@property(nonatomic,strong)UIView * popView;
//遮罩
@property(nonatomic,strong)UIView * coverView;

@property(nonatomic,strong)UIButton * tTempBtn;
//判断上方的两个按钮是哪个点击。
@property(nonatomic,assign)int who;

@property (nonatomic,assign) BOOL show;
@property(nonatomic,copy)NSString * user_id;
@property (nonatomic,strong) UserInfo *userInfo;
@end

@implementation DYGSelectViewController

-(NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}

-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@{@"title":@"类型不限",@"id":@"0"}].mutableCopy;
    }
    return _titleArr;
}
-(NSArray *)moneyArr{
    if (!_moneyArr) {
        _moneyArr = @[@{@"start_money":@"0",@"end_money":@"0"},@{@"start_money":@"0",@"end_money":@"2000"},@{@"start_money":@"2000",@"end_money":@"5000"},@{@"start_money":@"5000",@"end_money":@"10000"},@{@"start_money":@"10000",@"end_money":@"0"}];
    }
    return _moneyArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [UserInfoManager getAccountInfo];
    self.user_id = self.userInfo.user_id;
    [self.titleArr addObjectsFromArray:self.selecArr];
    self.view.backgroundColor = [UIColor whiteColor];
    //    tabbar遮挡Cell
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self setUpNavBtn];
    [self setUpTabelView];
    [self setDefultValue];
    [self creatUI];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self loadData];
    self.tableView.tableFooterView = [UIView new];
    
}
-(void)setUpTabelView {
    self.isHidenNaviBar = NO;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 100, kScreenWidth,kScreenHeight-100);
    self.tableView.backgroundColor = KWhiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithHexString:@"eeeeee" alap:1];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

//-(void)setUpNavBtn{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//}
//-(void)back{
//    //    [self.navigationController popViewControllerAnimated:YES];
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

-(void)setDefultValue{
    self.index = 0;
    self.num = 5;
    self.sort = 0;
    self.start_money =@"0";
    self.end_money = @"0";
}
-(void)loadData{
    self.index = 0;

    [self postWithIndex:self.index WithNum:self.num WithCalss:self.btnId WithStartMoney:self.start_money WithEndMoney:self.end_money WithSort:self.sort];
}
-(void)loadNewData{
    [self loadData];
}
- (void)loadMoreData
{
    self.index = self.index+self.num;
    DLog(@"self.index:%ld",self.index);
    NSDictionary * parmas = @{@"uid":self.user_id,@"index":@(self.index),@"num":@(self.num),@"sort":@(self.sort),@"class":@(self.btnId),@"end_money":self.end_money,@"start_money":self.start_money};
    [FXHttpTool postWithURL:@"getHoleList" params:parmas sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        NSArray *arr = reslut[@"data"];
        if (arr.count>0) {
            for (NSDictionary * dict in reslut[@"data"]) {
                LoanDetailModel * model = [LoanDetailModel modelWithDictionary:dict];
                [self.dataArry addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        DLog(@"DataArray:%ld",self.dataArry.count);
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
    }];
}
#pragma mark      change type send's method
-(void)postWithIndex:(NSInteger)index WithNum:(NSInteger)num WithCalss:(NSInteger)btnID WithStartMoney:(NSString *)startMoney WithEndMoney:(NSString *)endMoney WithSort:(NSInteger)sort{
    NSDictionary * parmas = @{@"uid":self.user_id,@"index":@(index),@"num":@(num),@"sort":@(sort),@"class":@(btnID),@"end_money":endMoney,@"start_money":startMoney};
    self.tableView.mj_footer.state =MJRefreshStateIdle;
    [FXHttpTool postWithURL:@"getHoleList" params:parmas sucess:^(id json) {
        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        self.dataArry = nil;
        for (NSDictionary * dict in reslut[@"data"]) {
            LoanDetailModel * model = [LoanDetailModel modelWithDictionary:dict];
            [self.dataArry addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        DLog(@"=========DataArray:=========%ld",self.dataArry.count);
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)creatUI{
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.popView];
    [self.typeView addSubview:self.moneyBtn];
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.typeView.mas_left).offset(63);
        make.left.equalTo(self.typeView.mas_left).offset(35);
        make.centerY.equalTo(self.typeView.mas_centerY);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    self.moneyBtn.tag = 51;
    self.typeBtn.tag = 52;
    [self.moneyBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeView addSubview:self.typeBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right).offset(-54);
        make.right.equalTo(self.typeView.mas_right).offset(-35);
        make.centerY.equalTo(self.typeView.mas_centerY);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    [self.moneyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.moneyBtn.imageView.bounds.size.width, 0, self.moneyBtn.imageView.bounds.size.width)];
    [self.moneyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.moneyBtn.titleLabel.bounds.size.width, 0, -self.moneyBtn.titleLabel.bounds.size.width)];
    [self.typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.typeBtn.imageView.bounds.size.width, 0, self.typeBtn.imageView.bounds.size.width)];
    [self.typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.typeBtn.titleLabel.bounds.size.width, 0, -self.typeBtn.titleLabel.bounds.size.width)];
    [self.typeBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat btnMargin = 18;
    CGFloat margin = 12;
    CGFloat btnW = (kScreenWidth - 2*margin - 3*btnMargin)/4;
    CGFloat btnH = 25;
    NSArray * titleArray = @[@"综合排序",@"通过率高",@"下款最快",@"利率最低"];
    for (int i = 0; i<4; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((btnMargin+btnW)*i+margin,13, btnW, btnH)];
        btn.tag = 201+i;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"555555" alap:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"1da9ff" alap:1] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"1da9ff" alap:1] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"round"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius =5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(subTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTypeView addSubview:btn];
    }
}
//创建弹出视图子控件。
-(void)creatPopViewSubViewsWithArray:(NSArray *)array{
    CGFloat sideMargin = 35;
    CGFloat itemMargin = 68;
    CGFloat itemW = (kScreenWidth -2*sideMargin -itemMargin)/2;
    CGFloat itemH = 30;
    CGFloat topMargin = 25;
    CGFloat itemTMargin = 16;
    CGFloat h = 0.0 ;
    for (int i =0  ; i<array.count;i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i%2*(itemW + itemMargin)+sideMargin,topMargin+(itemH + itemTMargin)*(i/2), itemW, itemH)];
        [btn setTitle:array[i][@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"1da9ff" alap:1] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"555555" alap:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setBackgroundImage:[UIImage imageNamed:@"round_selected"] forState:UIControlStateSelected];
        btn.tag = 401+i;
        [btn addTarget:self action:@selector(typeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==array.count-1) {
            h = CGRectGetMaxY(btn.frame);
        }
        [self.popView addSubview:btn];
    }
    UIButton * czBtn = [[UIButton alloc]init];
    [czBtn setTitle:@"重置" forState:UIControlStateNormal];
    [czBtn setTitleColor:[UIColor colorWithHexString:@"555555" alap:1] forState:UIControlStateNormal];
    [czBtn setBackgroundColor:[UIColor whiteColor]];
    czBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    czBtn.tag =301;
    [self.popView addSubview:czBtn];
    [czBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.popView.mas_left);
        make.bottom.equalTo(self.popView.mas_bottom);
        make.width.equalTo(@(kScreenWidth/2));
        make.height.equalTo(@(44));
    }];
    [czBtn addTarget:self action:@selector(surnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.tag = 302;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"1da9ff" alap:1]];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.popView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.popView.mas_right);
        make.bottom.equalTo(self.popView.mas_bottom);
        make.width.equalTo(@(kScreenWidth/2));
        make.height.equalTo(@(44));
    }];
    [sureBtn addTarget:self action:@selector(surnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView * line1 = [UIView new];
    line1.backgroundColor = [UIColor colorWithHexString:@"f2f2f2" alap:1];
    [self.popView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.popView.mas_left);
        make.width.equalTo(self.popView.mas_width);
        make.top.equalTo(self.popView.mas_top);
        make.height.equalTo(@1);
    }];
    UIView * line2 = [UIView new];
    line2.backgroundColor = [UIColor colorWithHexString:@"f2f2f2" alap:1];
    [self.popView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.popView.mas_left);
        make.width.equalTo(self.popView.mas_width);
        make.bottom.equalTo(czBtn.mas_top);
        make.height.equalTo(@1);
    }];
    self.popView.frame = CGRectMake(0, 50, kScreenWidth,h+69);
    self.coverView.frame = CGRectMake(0,CGRectGetMaxY(self.popView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.popView.frame));

}
#pragma mark   内部选择点击事件
-(void)typeBtnDidClick:(UIButton *)btn{
//    NSInteger index = btn.tag-401;
    if (self.ntempBtn==btn) {
        btn.selected = !btn.selected;
    }else{
        btn.selected = YES;
        self.ntempBtn.selected = NO;
        self.ntempBtn = btn;
    }
}
#pragma mark     确定重置点击事件
-(void)surnBtnClick:(UIButton *)btn{
    if (self.who==51) {
        switch (btn.tag) {
            case 301:
                self.ntempBtn.selected = NO;
//                self.ntempBtn.tag = MAXFLOAT;
                self.ntempBtn = (UIButton *)[self.view viewWithTag:401];
                self.ntempBtn.selected = YES;
                break;
            case 302:
                if (self.ntempBtn.selected) {
                    [self.moneyBtn setTitle:self.ntempBtn.titleLabel.text forState:UIControlStateNormal];
                    [self.moneyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.moneyBtn.imageView.bounds.size.width, 0, self.moneyBtn.imageView.bounds.size.width)];
                    [self.moneyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.moneyBtn.titleLabel.bounds.size.width, 0, -self.moneyBtn.titleLabel.bounds.size.width)];
                    self.start_money = self.moneyArr[self.ntempBtn.tag-401][@"start_money"];
                    self.end_money = self.moneyArr[self.ntempBtn.tag-401][@"end_money"];
                    [self hideCoverAndPopView];
                    [self postWithIndex:0 WithNum:5 WithCalss:self.btnId WithStartMoney:self.start_money WithEndMoney:self.end_money WithSort:self.sort];
                }else{
                    [self hideCoverAndPopView];
                    self.ntempBtn.tag = 0;
                }
                break;
        }
 
    }else if (self.who==52) {
        switch (btn.tag) {
            case 301:
                self.ntempBtn.selected = NO;
//                self.ntempBtn.tag = 0;
                self.ntempBtn = (UIButton *)[self.view viewWithTag:401];
                self.ntempBtn.selected = YES;
                break;
            case 302:
                if (self.ntempBtn.selected) {
                    [self.typeBtn setTitle:self.ntempBtn.titleLabel.text forState:UIControlStateNormal];
                    [self.typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.typeBtn.imageView.bounds.size.width, 0, self.typeBtn.imageView.bounds.size.width)];
                    [self.typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.typeBtn.titleLabel.bounds.size.width, 0, -self.typeBtn.titleLabel.bounds.size.width)];
                    NSString * str = self.titleArr[self.ntempBtn.tag-401][@"id"];
                    self.btnId = str.integerValue;
                    [self hideCoverAndPopView];
//                    [self postWithIndex:0 WithNum:5 WithCalss:self.btnId];
                    [self postWithIndex:0 WithNum:5 WithCalss:self.btnId WithStartMoney:self.start_money WithEndMoney:self.end_money WithSort:self.sort];
                }else{
                    [self hideCoverAndPopView];
                    self.ntempBtn.tag = 0;
                }
                break;
        }
    }
    }

#pragma mark 下方类型选择
-(void)subTypeBtnClick:(UIButton *)btn{
    
    if (self.tempBtn.tag==btn.tag) {
        btn.selected = !btn.selected;
    }else{
        btn.selected = !btn.selected;
        self.tempBtn.selected = NO;
        self.tempBtn = btn;
    }
    self.sort =  btn.tag - 201;
    [self postWithIndex:0 WithNum:5 WithCalss:self.btnId WithStartMoney:self.start_money WithEndMoney:self.end_money WithSort:self.sort];
}
//coverView点击事件
-(void)coverViewDidClick{
    [self hideCoverAndPopView];
}
#pragma mark TablView DataSource 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
    
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * reuseID =@"messageCell";
//    DYGSelectMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    DYGMessageDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[DYGMessageDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.model = self.dataArry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//上方点击事件
-(void)selectBtnClick:(UIButton *)btn{
    DLog(@"btn.tag:%ld",btn.tag);
    DLog(@"show%d",self.show);
    if (self.tTempBtn.tag==btn.tag) {
        btn.selected = !btn.selected;
        self.show = !self.show;
    }else{
        btn.selected = !btn.selected;
        self.tTempBtn.selected = NO;
        self.tTempBtn = btn;
        self.show = YES;
    }
    self.who = (int)btn.tag;
    for (id view in self.popView.subviews) {
        [view removeFromSuperview];
    }
    if (self.show) {
        [self.view bringSubviewToFront:self.popView];
        [self showCoverAndPopView];
    }else{
        [self hideCoverAndPopView];
    }
    if (btn.tag==51) {
        NSArray * moneyArr = @[@{@"title":@"金额不限"},@{@"title":@"2000元以下"},@{@"title":@"2000-5000元"},@{@"title":@"5000-10000元"},@{@"title":@"10000元以上"}];
        [self creatPopViewSubViewsWithArray:moneyArr];
    }else{
//        NSArray * selecArr = @[@"类型不限",@"小额极速贷",@"大额借款",@"代还信用卡",@"身份证下款",@"学生贷",@"10分钟秒批",@"芝麻分贷款",@"信用贷"];
        [self creatPopViewSubViewsWithArray:self.titleArr];
    }
}
-(void)hideCoverAndPopView{
    for (id view in self.popView.subviews) {
        [view removeFromSuperview];
    }
//    DLog(@"btn.tag:%ld",self.ntempBtn.tag);
//    DLog(@"show%d",self.show);
    [UIView animateWithDuration:0.1 animations:^{
        self.ntempBtn.selected = NO;
        self.ntempBtn.tag = 0;
        self.moneyBtn.selected = NO;
        self.typeBtn.selected = NO;
        self.popView.alpha = 0;
        self.coverView.alpha = 0;
        self.show = NO;
    }];
    
}
-(void)showCoverAndPopView{
    self.popView.alpha = 1;
    self.coverView.alpha = 0.6;
}

#pragma mark Cell 点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LoanDetailModel * model =self.dataArry[indexPath.row];
    NSDictionary * params = @{@"uid":self.user_id,@"hole_id":model.ID};
    [FXHttpTool postWithURL:@"getHolePart" params:params sucess:^(id json) {
        id resutl = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        LoanDetailModel * model = [LoanDetailModel modelWithDictionary:resutl[@"data"]];
        DYGDetailMessageViewController * vc = [[DYGDetailMessageViewController alloc]init];
        vc.model = model;
        vc.neesArray = model.material_str;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148;
}



#pragma mark lazy Load
-(UIButton *)tempBtn{
    if (!_tempBtn) {
        _tempBtn = [[UIButton alloc]init];
    }
    return _tempBtn;
}

-(UIButton *)ntempBtn{
    if (!_ntempBtn) {
        _ntempBtn = [[UIButton alloc]init];
    }
    return _ntempBtn;
}
//-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth,kScreenHeight-100) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.showsVerticalScrollIndicator = NO;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.tableView.separatorColor = [UIColor colorWithHexString:@"eeeeee" alap:1];
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}

-(UIView *)typeView{
    if (!_typeView) {
        _typeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _typeView.backgroundColor = [UIColor whiteColor];
        //        _typeView.borderColor = [UIColor colorWithHexString:@"999999" alpha:1];
        //        _typeView.borderWidth = 0.5;
        
        [self.view addSubview:_typeView];
    }
    return _typeView;
}

-(UIView *)subTypeView{
    if (!_subTypeView) {
        _subTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 50)];
        _subTypeView.backgroundColor = [UIColor whiteColor];
        //        _subTypeView.borderColor = [UIColor colorWithHexString:@"f2f2f2" alpha:1];
        //        _subTypeView.borderWidth = 0.5;
        [self.view addSubview:_subTypeView];
    }
    return _subTypeView;
}

-(UIButton *)moneyBtn{
    if (!_moneyBtn) {
        _moneyBtn = [[UIButton alloc]init];
        [_moneyBtn setTitle:@"金额不限" forState:UIControlStateNormal];
        _moneyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moneyBtn setTitleColor:[UIColor colorWithHexString:@"555555" alap:1] forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:[UIColor colorWithHexString:@"1da9ff" alap:1] forState:UIControlStateSelected];
        [_moneyBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_moneyBtn setImage:[UIImage imageNamed:@"up_selected"] forState:UIControlStateSelected];
        [_moneyBtn.titleLabel sizeToFit];
    }
    return _moneyBtn;
}

-(UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc]init];
        switch (self.btnId) {
            case 4:
                [_typeBtn setTitle:@"小额急速贷款" forState:UIControlStateNormal];
                break;
            case 5:
                [_typeBtn setTitle:@"代还信用卡" forState:UIControlStateNormal];
                break;
            case 6:
                [_typeBtn setTitle:@"身份证下款" forState:UIControlStateNormal];
                break;
            case 7:
                [_typeBtn setTitle:@"10分钟秒批" forState:UIControlStateNormal];
                break;
            default:
                [_typeBtn setTitle:@"类型不限" forState:UIControlStateNormal];
                break;
        }
//        [_typeBtn setTitle:@"类型不限" forState:UIControlStateNormal];
        _typeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_typeBtn setTitleColor:[UIColor colorWithHexString:@"555555" alap:1] forState:UIControlStateNormal];
        [_typeBtn setTitleColor:[UIColor colorWithHexString:@"1da9ff" alap:1] forState:UIControlStateSelected];
        [_typeBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_typeBtn setImage:[UIImage imageNamed:@"up_selected"] forState:UIControlStateSelected];
    }
    return _typeBtn;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _line1.backgroundColor = [UIColor colorWithHexString:@"c1c1c1" alap:1];
    }
    return _line1;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 0.5)];
        _line2.backgroundColor = [UIColor colorWithHexString:@"f2f2f2" alap:1];
        
    }
    return _line2;
}

-(UIView *)popView{
    if (!_popView) {
        //        _popView = [[UIView alloc]initWithFrame:CGRectMake(0,50, kScreenWidth, 210)];
        _popView = [[UIView alloc]init];
        _popView.backgroundColor = [UIColor whiteColor];
        [self.view bringSubviewToFront:_popView];
        _popView.alpha = 0;
    }
    return _popView;
}

-(UIView *)coverView{
    if (!_coverView) {
        //        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 260, kScreenWidth, kScreenHeight - 260)];
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewDidClick)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}
@end













