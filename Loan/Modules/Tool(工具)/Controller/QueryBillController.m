//
//  QueryBillController.m
//  Loan
//
//  Created by FanXing on 2018/3/26.
//  Copyright © 2018年 FanXing. All rights reserved.
//

#import "QueryBillController.h"
#import "TextFieldCell.h"
#import "XZPickView.h"
#import <MessageUI/MessageUI.h>
@interface QueryBillController ()<UITableViewDataSource,UITableViewDelegate,XZPickViewDelegate,XZPickViewDataSource, MFMessageComposeViewControllerDelegate>
@property (nonatomic,strong) UIButton *queryBtn;

@property (nonatomic,strong) XZPickView *pickView;
@property (nonatomic,strong) NSArray *pickViewArray;

@property (nonatomic,strong) UILabel *bankNameLb;

@property (nonatomic,strong) UITextField *numberTf;

@property (nonatomic,strong) NSDictionary *selectedData; //标识选中的数据
@end

@implementation QueryBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查信用卡余额";
    [self setUpUI];
}

-(void)setUpUI {
    
    self.view.backgroundColor = CViewBgColor;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 8, KScreenWidth, KScreenHeight -kStatusBarHeight);
    self.tableView.backgroundColor = CViewBgColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = CLineColor;
    
    [self addTableFooterView];
}

#pragma mark ------添加脚视图
-(void)addTableFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptedHeight(250))];
    self.tableView.tableFooterView = footerView;
    
    UILabel *tipsLabel = [UILabel new];
    tipsLabel.text = @"通过发送短信查询信用卡余额，手机运营商（中国移动或联通、电话）或向你收取0.1元短信服务费用。";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = kAdaptedFontSize(12);
    tipsLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
    [footerView addSubview:tipsLabel];
    [tipsLabel sizeToFit];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).offset(8);
        make.left.equalTo(footerView.mas_left).offset(13);
        make.right.equalTo(footerView.mas_right).offset(-13);
    }];
    
    
    [footerView addSubview:self.queryBtn];
    [self.queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLabel.mas_bottom).offset(100);
        make.centerX.equalTo(footerView.mas_centerX);
        make.width.equalTo(@302);
        make.height.equalTo(@44);
    }];
}
#pragma mark ------ UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAdaptedHeight(45);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row==0) {
        static NSString *rid0=@"reuseCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid0];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:rid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"所属银行";
        cell.detailTextLabel.text = @"请选择所属银行";
        cell.textLabel.font = kAdaptedFontSize(15);
        cell.detailTextLabel.font = kAdaptedFontSize(15);
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"c7c7cd"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.bankNameLb = cell.detailTextLabel;
        return cell;
    }else {
        static NSString *rid1=@"reuseCell2";
        
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid1];
        
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"信用卡尾号";
        cell.textField.placeholder = @"请输入信用卡尾号";
        self.numberTf = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%zd",indexPath.row);
    if (indexPath.row == 0) {
        [self.view endEditing:YES];
        [self.pickView reloadData];
        [kAppWindow addSubview:self.pickView];
        [self.pickView show];
    }
}

#pragma mark -  XZPickView 代理
//列数
-(NSInteger)numberOfComponentsInPickerView:(XZPickView *)pickerView{
    return 1;
}

//行数
-(NSInteger)pickerView:(XZPickView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickViewArray.count;
}

//标题
-(NSString *)pickerView:(XZPickView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dict = self.pickViewArray[row];
    return dict[@"name"];
    
}
//确认按钮点击
-(void)pickView:(XZPickView *)pickerView confirmButtonClick:(UIButton *)button{
    NSInteger left = [pickerView selectedRowInComponent:0];
    DLog(@"%ld",left);
    self.selectedData = self.pickViewArray[left];
    self.bankNameLb.text = self.selectedData[@"name"];
    self.bankNameLb.textColor = [UIColor blackColor];
    
}

//滑动选中
-(void)pickerView:(XZPickView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger left = [pickerView selectedRowInComponent:component];
    DLog(@"%ld",left);
    self.selectedData = self.pickViewArray[left];
    self.bankNameLb.text = self.selectedData[@"name"];
    self.bankNameLb.textColor = [UIColor blackColor];
}
#pragma mark ------去查询
-(void)queryBtnAction {
    
    if ([self.bankNameLb.text isEqualToString:@"请选择所属银行"]) {
        [MBProgressHUD showTipMessageInView:@"请选择所属银行"];
        return;
    }
    
    if (self.numberTf.text.length!=4) {
        [MBProgressHUD showTipMessageInView:@"请输入正确的信用卡尾号"];
        return;
    }
    NSString *phoneStr = self.selectedData[@"number"];//发短信的号码
    NSString *smsContentStr = NSStringFormat(@"%@%@",self.selectedData[@"prefix"],self.numberTf.text);
    NSString *urlStr = [NSString stringWithFormat:@"sms://%@&body=%@", phoneStr, smsContentStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
//    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
//    // 设置短信内容
//    vc.body = NSStringFormat(@"%@%@",self.selectedData[@"prefix"],self.numberTf.text);
//    vc.navigationBar.tintColor = KWhiteColor;
//    vc.navigationBar.barTintColor = KWhiteColor;
//    // 设置收件人
//    vc.recipients = @[self.selectedData[@"number"]];  // 号码
//    // 设置代理
//    vc.messageComposeDelegate = self;
//    // 显示控制器
//    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark ------MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        DLog(@"取消发送");
        [MBProgressHUD showTipMessageInView:@"取消发送"];
    } else if(result == MessageComposeResultSent) {
        DLog(@"已经发出");
        [MBProgressHUD showTipMessageInView:@"发送成功"];
    } else {
        DLog(@"发送失败");
        [MBProgressHUD showTipMessageInView:@"发送失败"];
    }
}



-(UIButton *)queryBtn {
    if (!_queryBtn) {
        _queryBtn = [[UIButton alloc] init];
        _queryBtn.layer.cornerRadius = 6;
        _queryBtn.layer.masksToBounds = YES;
        [_queryBtn setTitle:@"去查询" forState:UIControlStateNormal];
        _queryBtn.titleLabel.font = kAdaptedFontSize(16);
        _queryBtn.backgroundColor = CNavBgColor;
        [_queryBtn addTarget:self action:@selector(queryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryBtn;
}

-(XZPickView *)pickView{
    if(!_pickView){
        _pickView = [[XZPickView alloc]initWithFrame:kScreen_Bounds title:@"请选择"];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

-(NSArray *)pickViewArray {
    if (!_pickViewArray) {
        
        _pickViewArray = @[
                           @{
                               @"name":@"中国光大银行",
                               @"number":@"95595",
                               @"prefix":@"额度#"
                            },
                           @{
                               @"name":@"平安银行",
                               @"number":@"95511",
                               @"prefix":@"ED"
                            },
                           @{
                               @"name":@"广发银行",
                               @"number":@"95508",
                               @"prefix":@"900"
                            },
                           
                           @{
                               @"name":@"中国民生银行",
                               @"number":@"95568",
                               @"prefix":@"ED"
                            },
                           @{
                               @"name":@"华夏银行",
                               @"number":@"95577",
                               @"prefix":@"YE"
                            },
                           @{
                               @"name":@"中国银行",
                               @"number":@"95566",
                               @"prefix":@"1#"
                            },
                           @{
                               @"name":@"中国建设银行",
                               @"number":@"95533",
                               @"prefix":@"CCYE#"
                            },
                           @{
                               @"name":@"交通银行",
                               @"number":@"95559",
                               @"prefix":@"CC余额#"
                            },
                           @{
                               @"name":@"招商银行",
                               @"number":@"95555",
                               @"prefix":@"#ED"
                            },
                           @{
                               @"name":@"中信银行",
                               @"number":@"106980095558",
                               @"prefix":@"YE"
                            },
                           ];
    }
    return _pickViewArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
