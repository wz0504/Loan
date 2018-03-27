//
//  DYGDetailMessageViewController.m
//  CS2.1
//
//  Created by Mr_Du on 2017/8/8.
//  Copyright © 2017年 Mr_Du. All rights reserved.
//

#import "DYGDetailMessageViewController.h"
#import "LoanDetailModel.h"

#import "DYGWKWebView.h"
@interface DYGDetailMessageViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
#pragma mark 数据相关


@property(nonatomic,strong)UIScrollView * scrollView;
//********************************上方view*************************** 466
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIImageView * iconImg;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * tMessage;
@property (nonatomic,strong) UIButton * collectBtn;
@property (nonatomic,strong) UIView *lin1;
@property (nonatomic,strong) UIView * orangeView;
@property (nonatomic,strong) UIView * redView;
@property (nonatomic,strong) UIView * deepBlueView;
@property (nonatomic,strong) UIView *blueView;
@property (nonatomic,strong) UILabel * canApplyNumTitle;
@property (nonatomic,strong) UILabel *canApplyNum;
@property (nonatomic,strong) UILabel * monthRateTitle;
@property (nonatomic,strong) UILabel *monthRateNum;
@property (nonatomic,strong) UILabel *fastTimeTitle;
@property (nonatomic,strong) UILabel *fastTimeNum;
@property (nonatomic,strong) UILabel *applyNumTitle;
@property (nonatomic,strong) UILabel *applyNum;
@property (nonatomic,strong) UILabel *sucessRateTitle;
@property (nonatomic,strong) UILabel *sucessRateNum;

//********************************下方view*************************** 460
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UIView *lightBlueView;
@property(nonatomic,strong) UIView *line2;
//申请资格
@property (nonatomic,strong) UILabel *applyCTitle;
@property (nonatomic,strong) UILabel *applyChange;
@property (nonatomic,strong) UIView *lBlueView;
@property (nonatomic,strong) UILabel *needTitle;

//bottomView  260
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,strong) UIButton * submitBtn;
@property(nonatomic,copy)NSString * user_id;
@property (nonatomic,strong) UserInfo *userInfo;
@end

@implementation DYGDetailMessageViewController

//-(NSArray *)neesArray{
//    if (!_neesArray) {
//        _neesArray = @[@"身份证",@"个人基本信息",@"模拟信息1",@"模拟信息2"];
//    }
//    return _neesArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [UserInfoManager getAccountInfo];
    self.user_id = self.userInfo.user_id;
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.title = @"贷款";
    [self creatUI];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadData];
}
#pragma mark  数据加载
//-(void)loadData{
//    NSDictionary * parmas = @{@"uid":self.user_id,@"hole_id":self.hole_id};
//    [DYGHttpTool postWithURL:@"getHolePart" params:parmas sucess:^(id json) {
//        id reslut = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
//         self.model = [DYGHomeDetailModel yy_modelWithDictionary:reslut[@"data"]];
//        self.neesArray = self.model.material_str;
//        [self.scrollView reloadInputViews];
//        DYGLog(@"result:%@",reslut);
//    } failure:^(NSError *error) {
//        DYGLog(@"error:%@",error);
//    }];
//}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
#pragma mark creatUI And SetUpContract
-(void)creatUI{
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.midView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@130);
    }];
    [self.bottomView addSubview:self.submitBtn];
    CGFloat btnW = (CGFloat)650/750;
    CGFloat btnH = (CGFloat)80/1334;
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.width.equalTo(@(kScreenWidth * btnW));
        make.height.equalTo(@(kScreenHeight * btnH));
    }];
    [self.topView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(12);
        make.top.equalTo(self.topView.mas_top).offset(17);
        make.width.height.equalTo(@58);
    }];
    [self.topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(8);
        make.top.equalTo(self.topView.mas_top).offset(21);
    }];
    [self.topView addSubview:self.tMessage];
    [self.tMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(17);
    }];
    [self.topView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top).offset(14);
        make.right.equalTo(self.topView.mas_right).offset(-22);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
    }];
    [self.topView addSubview:self.lin1];
    [self.lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_left);
        make.right.equalTo(self.topView.mas_right);
        make.top.equalTo(self.iconImg.mas_bottom).offset(17);
        make.height.equalTo(@1);
    }];
    [self.topView addSubview:self.orangeView];
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(22);
        make.top.equalTo(self.lin1.mas_bottom).offset(17);
        make.width.height.equalTo(@9);
    }];
    [self.topView addSubview:self.canApplyNumTitle];
    [self.canApplyNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orangeView.mas_right).offset(9);
        make.centerY.equalTo(self.orangeView.mas_centerY);
    }];
    [self.topView addSubview:self.canApplyNum];
    [self.canApplyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(133);
        make.centerY.equalTo(self.canApplyNumTitle.mas_centerY);
    }];
    [self.topView addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orangeView.mas_left);
        make.top.equalTo(self.orangeView.mas_bottom).offset(20);
        make.width.height.equalTo(self.orangeView);
    }];
    [self.topView addSubview:self.monthRateTitle];
    [self.monthRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right).offset(9);
        make.centerY.equalTo(self.redView.mas_centerY);
    }];
    [self.topView addSubview:self.monthRateNum];
    [self.monthRateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(133);
        make.centerY.equalTo(self.monthRateTitle.mas_centerY);
    }];
    [self.topView addSubview:self.deepBlueView];
    [self.deepBlueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.redView);
        make.top.equalTo(self.redView.mas_bottom).offset(20);
    }];
    [self.topView addSubview:self.fastTimeTitle];
    [self.fastTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deepBlueView.mas_right).offset(9);
        make.centerY.equalTo(self.deepBlueView.mas_centerY);
    }];
    [self.topView addSubview:self.fastTimeNum];
    [self.fastTimeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(133);
        make.centerY.equalTo(self.fastTimeTitle.mas_centerY);
    }];
    [self.topView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.deepBlueView);
        make.top.equalTo(self.deepBlueView.mas_bottom).offset(20);
    }];
    [self.topView addSubview:self.applyNumTitle];
    [self.applyNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueView.mas_right).offset(9);
        make.centerY.equalTo(self.blueView.mas_centerY);
    }];
    [self.topView addSubview:self.applyNum];
    [self.applyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(133);
        make.centerY.equalTo(self.applyNumTitle.mas_centerY);
    }];
    [self.topView addSubview:self.sucessRateTitle];
    [self.sucessRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.sucessRateNum.mas_left);
//        make.top.equalTo(self.sucessRateNum.mas_bottom).offset(10);
        make.bottom.equalTo(self.applyNumTitle.mas_bottom).offset(-5);
        make.right.equalTo(self.topView.mas_right).offset(-50);
    }];
    [self.topView addSubview:self.sucessRateNum];
    [self.sucessRateNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.sucessRateTitle.mas_centerX);
        make.bottom.equalTo(self.sucessRateTitle.mas_top).offset(-10);
    }];
    [self.midView addSubview:self.lightBlueView];
    [self.lightBlueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midView.mas_left).offset(12);
        make.top.equalTo(self.midView.mas_top).offset(17);
        make.width.equalTo(@5);
        make.height.equalTo(@14);
    }];
    [self.midView addSubview:self.applyCTitle];
    [self.applyCTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lightBlueView.mas_right).offset(7);
        make.centerY.equalTo(self.lightBlueView.mas_centerY);
    }];
    [self.midView addSubview:self.applyChange];
    [self.applyChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applyCTitle.mas_left);
        make.top.equalTo(self.applyCTitle.mas_bottom).offset(17);
    }];
    [self.midView addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.midView.mas_width);
        make.top.equalTo(self.applyChange.mas_bottom).offset(17);
        make.height.equalTo(@1);
    }];
    [self.midView addSubview:self.lBlueView];
    [self.lBlueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.lightBlueView);
        make.top.equalTo(self.line2.mas_bottom).offset(17);
    }];
    [self.midView addSubview:self.needTitle];
    [self.needTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lBlueView.mas_right).offset(7);
        make.centerY.equalTo(self.lBlueView.mas_centerY);
    }];
//    DYGLog(@"MAX:%f",CGRectGetMaxY(self.needTitle.frame));
    CGFloat marign = 17;
    CGFloat leftMargin = 24;
    CGFloat maxH = 0;
//    self.neesArray = @[@"模拟信息1",@"模拟信息2",@"模拟信息3",@"模拟信息4",@"模拟信息5",@"模拟信息6",@"模拟信息7",@"模拟信息8"];
    for (int i = 0; i<self.neesArray.count; i++) {
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(leftMargin, 132+(marign+12)*i,200 , 12);
        label.text = self.neesArray[i][@"title"];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHexString:@"909090"];
        [self.midView addSubview:label];
        if (i==self.neesArray.count-1) {
            maxH = CGRectGetMaxY(label.frame);
        }
    }
    if (maxH>10) {
        self.midView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, kScreenWidth, maxH+marign);
    }else{
        self.midView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, kScreenWidth, 200);
    }
    if (CGRectGetMaxY(self.midView.frame)<(kScreenHeight-194)) {
        self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.midView.frame));
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.midView.frame));
}
#pragma mark btnClick
//收藏点击事件
-(void)collecBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
//    btn.selected?[self popViewWithText:@"收藏成功"]:[self popViewWithText:@"取消收藏"];
//    NSDictionary * params = @{@"uid":[DYGUserInfo getUser_ID],@"hole_id":self.model.ID};
//    NSString * url = @"";
//    btn.selected?(url = @"collHoleTrue"):(url = @"collHoleFalse");
//    [DYGHttpTool postWithURL:url params:params sucess:^(id json) {
//        id resutl = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
//        [self popViewWithText:resutl[@"msg"]];
//    } failure:^(NSError *error) {
//        DYGLog(@"%@",error);
//    }];
}

-(void)popViewWithText:(NSString *)string{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = string;
    hud.bezelView.color = [UIColor colorWithHexString:@"848280" ];
    hud.label.textColor =[UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:17];
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark 点击事件
-(void)submitBtnClick{
    NSDictionary * params = @{@"uid":self.user_id,@"hole_id":self.model.ID};
    [FXHttpTool postWithURL:@"applyHole" params:params sucess:^(id json) {
        id result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        NSString * str =[NSString stringWithFormat:@"%@",result[@"data"][@"open"]];
        if ([str isEqualToString:@"1"]) {
            DYGWKWebView * vc = [[DYGWKWebView alloc]init];
            vc.url = result[@"data"][@"href"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSURL * url = [NSURL URLWithString:result[@"data"][@"href"]];
            [[UIApplication sharedApplication]openURL:url];
        }
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}









#pragma mark lazyLoad

-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [[UIButton alloc]init];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"starSelected"] forState:UIControlStateSelected];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"starNormal"] forState:UIControlStateNormal];
//        if (self.model.is_coll==1) {
//            _collectBtn.selected = YES;
//        }
        [_collectBtn addTarget:self action:@selector(collecBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height-130-64);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        //        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 233)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UIView *)midView{
    if (!_midView) {
        _midView =[[UIView alloc]init];
        _midView.backgroundColor = [UIColor whiteColor];
    }
    return _midView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn =[[UIButton alloc]init];
        [_submitBtn setTitle:@"立即提交" forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 5;
        _submitBtn.layer.masksToBounds= YES;
        [_submitBtn setBackgroundColor:[UIColor colorWithHexString:@"1da9ff"]];
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        [_iconImg sd_setImageWithURL:[NSURL URLWithString:self.model.img_path]];
    }
    return _iconImg;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = self.model.title;
        _titleLabel.textColor = [UIColor colorWithHexString:@"555555"];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    }
    return _titleLabel;
}
-(UILabel *)tMessage{
    if (!_tMessage) {
        _tMessage = [[UILabel alloc]init];
//        _tMessage.text = @"凭身份证2000-3000元,最快1小时到账";
        _tMessage.text = self.model.abstr;
        _tMessage.textColor = [UIColor colorWithHexString:@"555555"];
        _tMessage.font = [UIFont systemFontOfSize:14];
    }
    return _tMessage;
}
-(UIView *)lin1{
    if (!_lin1) {
        _lin1 = [[UIView alloc]init];
        _lin1.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }
    return _lin1;
}
-(UIView *)orangeView{
    if (!_orangeView) {
        _orangeView = [[UIView alloc]init];
        _orangeView.backgroundColor = [UIColor colorWithHexString:@"faa72e"];
    }
    return _orangeView;
}
-(UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = [UIColor colorWithHexString:@"f26b55" ];
    }
    return _redView;
}
-(UIView *)deepBlueView{
    if (!_deepBlueView) {
        _deepBlueView = [[UIView alloc]init];
        _deepBlueView.backgroundColor = [UIColor colorWithHexString:@"2467b0" ];
    }
    return _deepBlueView;
}
-(UIView *)blueView{
    if (!_blueView) {
        _blueView = [[UIView alloc]init];
        _blueView.backgroundColor = [UIColor colorWithHexString:@"5496ff" ];
    }
    return _blueView;
}
-(UILabel *)canApplyNumTitle{
    if (!_canApplyNumTitle) {
        _canApplyNumTitle = [[UILabel alloc]init];
        _canApplyNumTitle.text =@"可借额度";
        _canApplyNumTitle.textColor = [UIColor colorWithHexString:@"555555" ];
        _canApplyNumTitle.font = [UIFont systemFontOfSize:13];
    }
    return _canApplyNumTitle;
}
-(UILabel *)canApplyNum{
    if (!_canApplyNum) {
        _canApplyNum = [[UILabel alloc]init];
//        _canApplyNum.text = @"0.2-3万";
        _canApplyNum.font = [UIFont systemFontOfSize:12];
        _canApplyNum.textColor = [UIColor colorWithHexString:@"f56f3a" ];
        NSString * str = [NSString stringWithFormat:@"%@-%@元",self.model.quota_s,self.model.quota_l];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.model.quota_s,self.model.quota_l]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.model.quota_s,self.model.quota_l]].length);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:bigRange];
        _canApplyNum.attributedText = att;

    }
    return _canApplyNum;
}

-(UILabel *)monthRateTitle{
    if (!_monthRateTitle) {
        _monthRateTitle = [[UILabel alloc]init];
        _monthRateTitle.text =@"参考月息";
        _monthRateTitle.textColor = [UIColor colorWithHexString:@"555555"];
        _monthRateTitle.font = [UIFont systemFontOfSize:13];
    }
    return _monthRateTitle;
}
-(UILabel *)monthRateNum{
    if (!_monthRateNum) {
        _monthRateNum = [[UILabel alloc]init];
//        _monthRateNum.text = @"1.3%";
        _monthRateNum.font = [UIFont systemFontOfSize:12];
        _monthRateNum.textColor = [UIColor colorWithHexString:@"f56f3a"];
        NSString * str = [NSString stringWithFormat:@"%@%%",self.model.monthly_s];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.monthly_s]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.monthly_s]].length);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:bigRange];
        _monthRateNum.attributedText = att;
    }
    return _monthRateNum;
}
-(UILabel *)fastTimeTitle{
    if (!_fastTimeTitle) {
        _fastTimeTitle = [[UILabel alloc]init];
        _fastTimeTitle.text = @"最快下款时间";
        _fastTimeTitle.textColor = [UIColor colorWithHexString:@"555555"];
        _fastTimeTitle.font = [UIFont systemFontOfSize:13];
    }
    return _fastTimeTitle;
}

-(UILabel *)fastTimeNum{
    if (!_fastTimeNum) {
        _fastTimeNum = [[UILabel alloc]init];
//        _fastTimeNum.text = @"3分钟";
        _fastTimeNum.font = [UIFont systemFontOfSize:12];
        _fastTimeNum.textColor = [UIColor colorWithHexString:@"f56f3a"];
        NSString * str = [NSString stringWithFormat:@"%@小时",self.model.enter_time];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.enter_time]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.enter_time]].length);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:bigRange];
        _fastTimeNum.attributedText = att;
    }
    return _fastTimeNum;
}
-(UILabel *)applyNumTitle{
    if (!_applyNumTitle) {
        _applyNumTitle = [[UILabel alloc]init];
        _applyNumTitle.textColor = [UIColor colorWithHexString:@"555555"];
        _applyNumTitle.text = @"申请人数";
        _applyNumTitle.font = [UIFont systemFontOfSize:13];
    }
    return _applyNumTitle;
}
-(UILabel *)applyNum{
    if (!_applyNum) {
        _applyNum = [[UILabel alloc]init];
//        _applyNum.text = @"9999人";
        _applyNum.font = [UIFont systemFontOfSize:12];
        _applyNum.textColor = [UIColor colorWithHexString:@"f56f3a"];
        NSString * str = [NSString stringWithFormat:@"%@人",self.model.apply_num];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.apply_num]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.apply_num]].length);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:bigRange];
        _applyNum.attributedText = att;
    }
    return _applyNum;
}

-(UILabel *)sucessRateTitle{
    if (!_sucessRateTitle) {
        _sucessRateTitle = [[UILabel alloc]init];
        _sucessRateTitle.text = @"贷款成功率";
        _sucessRateTitle.textColor =[UIColor colorWithHexString:@"909090"];
        _sucessRateTitle.font = [UIFont systemFontOfSize:12];
    }
    return _sucessRateTitle;
}

-(UILabel *)sucessRateNum{
    if (!_sucessRateNum) {
        _sucessRateNum = [[UILabel alloc]init];
//        _sucessRateNum.text = @"98%";
        _sucessRateNum.font = [UIFont systemFontOfSize:20];
        _sucessRateNum.textColor = [UIColor colorWithHexString:@"1da9ff"];
        NSString * str = [NSString stringWithFormat:@"%@%%",self.model.succrate_l];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange bigRange = NSMakeRange([[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.succrate_l]].location, [[att string]rangeOfString:[NSString stringWithFormat:@"%@",self.model.succrate_l]].length);
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:bigRange];
        _sucessRateNum.attributedText = att;
    }
    return _sucessRateNum;
}

-(UIView *)lightBlueView{
    if (!_lightBlueView) {
        _lightBlueView = [[UIView alloc]init];
        _lightBlueView.backgroundColor = [UIColor colorWithHexString:@"1da9ff" alap:1];
    }
    return _lightBlueView;
}

-(UILabel *)applyCTitle{
    if (!_applyCTitle) {
        _applyCTitle = [[UILabel alloc]init];
        _applyCTitle.text = @"申请资格";
        _applyCTitle.textColor = [UIColor colorWithHexString:@"333333" alap:1];
        _applyCTitle.font = [UIFont systemFontOfSize:16];
    }
    return _applyCTitle;
}
-(UILabel *)applyChange{
    if (!_applyChange) {
        _applyChange = [[UILabel alloc]init];
//        _applyChange.text = @"年满18周岁的大陆居民";
        _applyChange.text = self.model.seniority;
        _applyChange.textColor = [UIColor colorWithHexString:@"909090" alap:1];
        _applyChange.font = [UIFont systemFontOfSize:14];
    }
    return _applyChange;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"f2f2f2" alap:1];
    }
    return _line2;
}
-(UIView *)lBlueView{
    if (!_lBlueView) {
        _lBlueView = [[UIView alloc]init];
        _lBlueView.backgroundColor = [UIColor colorWithHexString:@"1da9ff" alap:1];
    }
    return _lBlueView;
}
-(UILabel *)needTitle{
    if (!_needTitle) {
        _needTitle = [[UILabel alloc]init];
        _needTitle.text =@"所需材料";
        _needTitle.textColor = [UIColor colorWithHexString:@"333333" alap:1];
        _needTitle.font = [UIFont systemFontOfSize:16];
    }
    return _needTitle;
}





@end












