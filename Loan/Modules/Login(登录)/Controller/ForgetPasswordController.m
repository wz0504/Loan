//
//  ForgetPasswordController.m
//  FlashPayBo
//
//  Created by FanXing on 2017/12/23.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "ForgetPasswordController.h"
#import "TimerHelper.h"
@interface ForgetPasswordController ()
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UILabel *timerLabel;
@property (nonatomic,strong) UITextField *passwordTf;
@end

@implementation ForgetPasswordController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //自动启动timer
    [TimerHelper timerCountDownWithKey:kTimerKeyRegister tipLabel:self.timerLabel forceStart:NO];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //取消timer
    [TimerHelper cancelTimerByKey:kTimerKeyRegister];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    [self setupUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)setupUI {
    //1. 添加logo
    UIImageView *logonImage = [[UIImageView alloc] init];
    logonImage.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logonImage];
    [logonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //添加手机号输入框
    [self.view addSubview:self.phoneTf];
    [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(45);
        make.right.equalTo(self.view.mas_right).offset(-45);
        make.top.equalTo(logonImage.mas_bottom).offset(kAdaptedHeight(50));
    }];
    
    //添加分割线
    UIView *phoneLine = [UIView new];
    phoneLine.backgroundColor = CLineColor;
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTf.mas_bottom).offset(13);
        make.left.equalTo(self.phoneTf.mas_left).offset(0);
        make.right.equalTo(self.phoneTf.mas_right).offset(0);
        make.height.equalTo(@1);
    }];
    
    //添加验证码输入框
    [self.view addSubview:self.codeTf];
    [self.codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(45);
        make.right.equalTo(phoneLine.mas_right).offset(-90);
        make.top.equalTo(phoneLine.mas_bottom).offset(22);
    }];
    
    //添加分割线
    UIView *marginLine = [UIView new];
    marginLine.backgroundColor = CLineColor;
    [self.view addSubview:marginLine];
    [marginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTf.mas_right).offset(0);
        make.centerY.equalTo(self.codeTf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 30));
    }];
    
    //添加倒计时
    [self.view addSubview:self.timerLabel];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phoneLine.mas_right).offset(0);
        make.centerY.equalTo(self.codeTf.mas_centerY);
        make.left.equalTo(marginLine.mas_right).offset(0);
        make.height.equalTo(@40);
    }];
    
    //添加分割线
    UIView *codeLine = [UIView new];
    codeLine.backgroundColor = CLineColor;
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTf.mas_bottom).offset(16);
        make.left.equalTo(self.codeTf.mas_left).offset(0);
        make.right.equalTo(self.timerLabel.mas_right).offset(0);
        make.height.equalTo(@1);
    }];
    
    //添加密码输入框
    [self.view addSubview:self.passwordTf];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(45));
        make.right.equalTo(self.view.mas_right).offset(-kAdaptedWidth(45));
        make.top.equalTo(codeLine.mas_bottom).offset(22);
    }];
    
    //添加分割线
    UIView *passwordLine = [UIView new];
    passwordLine.backgroundColor = CLineColor;
    [self.view addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTf.mas_bottom).offset(13);
        make.left.equalTo(self.passwordTf.mas_left).offset(0);
        make.right.equalTo(self.passwordTf.mas_right).offset(0);
        make.height.equalTo(@1);
    }];
    
    //添加密码控制按钮
    UIButton *seeBtn = [[UIButton alloc] init];
    [seeBtn setImage:[UIImage imageNamed:@"password_close"] forState:(UIControlStateNormal)];
    [seeBtn setImage:[UIImage imageNamed:@"password_open"] forState:UIControlStateSelected];
    [seeBtn addTarget:self action:@selector(seePasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeBtn];
    [seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-55);
        make.centerY.equalTo(self.passwordTf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //确认按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.backgroundColor = CNavBgColor;
    [sureBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:KWhiteColor forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = kAdaptedFontSize(16);
    ViewRadius(sureBtn, 22);
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLine.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(KScreenWidth-2*kAdaptedWidth(45)));
        make.height.equalTo(@44);
    }];
    
}

#pragma mark ---- 密码状态
-(void)seePasswordAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.passwordTf.secureTextEntry = !self.passwordTf.secureTextEntry;
}



#pragma mark -----发送验证码
- (void)sendCodeTouched:(UITapGestureRecognizer *)sender {
    if ([PatternHelper validateMobile:_phoneTf.text]) {
        UILabel *timerLabel = (UILabel *)sender.view;
        
        NSDictionary *params = @{@"phone":_phoneTf.text};
        [FXHttpTool postWithURL:@"getVercode" params:params sucess:^(id json) {
            id result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
            DLog(@"%@",result[@"msg"]);
            if ([result[@"code"] integerValue] == 200) {
                [TimerHelper startTimerWithKey:kTimerKeyRegister tipLabel:timerLabel];
                //TODO:一般都是调用服务端发送验证码接口，上面这行代码应该放到调用接口成功返回后再执行
            }else {
                [MBProgressHUD showTipMessageInView:result[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            DLog(@"%@",error);
        }];
    }else {
        [MBProgressHUD showTipMessageInView:@"请先输入正确的手机信息"];
    }
    
}

#pragma mark ---- 确认
-(void)sureAction {
    
    if (![PatternHelper validateMobile:self.phoneTf.text]) {
        [MBProgressHUD showTipMessageInView:@"请输入正确的手机号"];
        return;
    }
    
    if (![PatternHelper validateVerifyCode:self.codeTf.text]) {
        [MBProgressHUD showTipMessageInView:@"请输入正确格式的手机验证码"];
        return;
    }
    
    if (![PatternHelper validatePassword:self.passwordTf.text]) {
        [MBProgressHUD showTipMessageInView:@"请输入6-30位格式的密码"];
        return;
    }
    
    
    NSDictionary *params = @{@"phone":self.phoneTf.text,@"password":self.passwordTf.text,@"vercode":self.codeTf.text};
    [FXHttpTool postWithURL:@"findUser" params:params sucess:^(id json) {
        id result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",result);
        [MBProgressHUD showTipMessageInView:result[@"msg"]];
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD showTipMessageInView:@"密码找回成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor grayColor];
    
    UIButton *btnFished = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [btnFished setTitleColor:CNavBgColor forState:(UIControlStateNormal)];
    [btnFished setTitle:@"完成" forState:(UIControlStateNormal)];
    [btnFished addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btnFished];
    
    UIView *sapce = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - btnFished.frame.size.width - 30, 25)];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithCustomView:sapce];
    toolbar.items = @[bar1,bar];
    return toolbar;
}

-(void)textFieldDone {
    [self.view endEditing:YES];
}

#pragma mark ----- 键盘弹起
//键盘显示
- (void)keyboardWillShow:(NSNotification *)notification{
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    //    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = 50;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
//键盘消失
- (void)keyboardWillHide:(NSNotification *)notify{
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, kTopHeight, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark ---- lazyload
-(UITextField *)phoneTf {
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.textAlignment = NSTextAlignmentLeft;
        _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTf.font = kAdaptedFontSize(kAdaptedWidth(17));
        _phoneTf.placeholder = @"请输入手机号";
        _phoneTf.inputAccessoryView = [self addToolbar];
    }
    return _phoneTf;
}

-(UITextField *)codeTf {
    if (!_codeTf) {
        _codeTf = [[UITextField alloc] init];
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypeNumberPad;
        _codeTf.font = kAdaptedFontSize(kAdaptedWidth(17));
        _codeTf.placeholder = @"请输入验证码";
        _codeTf.inputAccessoryView = [self addToolbar];
    }
    return _codeTf;
}

-(UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] init];
        _timerLabel.font = kAdaptedFontSize(14);
        _timerLabel.text = @"获取验证码";
        _timerLabel.textColor = CHexColor(@"ec761f");
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.backgroundColor = KWhiteColor;
        _timerLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendCodeTouched:)];
        [_timerLabel addGestureRecognizer:tap];
    }
    return _timerLabel;
}
-(UITextField *)passwordTf {
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.textAlignment = NSTextAlignmentLeft;
        _passwordTf.keyboardType = UIKeyboardTypeDefault;
        _passwordTf.font = kAdaptedFontSize(kAdaptedWidth(17));
        _passwordTf.placeholder = @"请输入新密码";
        _passwordTf.secureTextEntry = YES;
        _passwordTf.inputAccessoryView = [self addToolbar];
    }
    return _passwordTf;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
