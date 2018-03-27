//
//  LoginViewController.m
//  FlashPayBo
//
//  Created by FanXing on 2017/12/23.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordController.h"
#import "MainTabBarController.h"
@interface LoginViewController ()
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *passwordTf;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";

    [self setupUI];
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
        make.left.equalTo(self.view.mas_left).offset(kAdaptedWidth(45));
        make.right.equalTo(self.view.mas_right).offset(-kAdaptedWidth(45));
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
    
    //添加密码输入框
    [self.view addSubview:self.passwordTf];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(45);
        make.right.equalTo(self.view.mas_right).offset(-45);
        make.top.equalTo(phoneLine.mas_bottom).offset(22);
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
    
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.backgroundColor = CNavBgColor;
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:KWhiteColor forState:(UIControlStateNormal)];
    loginBtn.titleLabel.font = kAdaptedFontSize(16);
    ViewRadius(loginBtn, 22);
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLine.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(KScreenWidth-2*kAdaptedWidth(45)));
        make.height.equalTo(@44);
    }];
    
    //添加注册按钮
    UIButton *registerBtn = [[UIButton alloc] init];
    [registerBtn setTitle:@"新人注册" forState:(UIControlStateNormal)];
    [registerBtn setTitleColor:CHexColor(@"ec761f") forState:(UIControlStateNormal)];
    registerBtn.titleLabel.font = kAdaptedFontSize(16);
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(30);
        make.right.equalTo(loginBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    //添加忘记密码按钮
    UIButton *forgetBtn = [[UIButton alloc] init];
    [forgetBtn setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"404040"] forState:(UIControlStateNormal)];
    forgetBtn.titleLabel.font = kAdaptedFontSize(16);
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //registerAction
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(30);
        make.left.equalTo(loginBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}
#pragma mark ---- 密码状态
-(void)seePasswordAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.passwordTf.secureTextEntry = !self.passwordTf.secureTextEntry;
}
#pragma mark ---- 登录
-(void)loginAction {
    DLog(@"登录");
    
    if (![PatternHelper validateMobile:self.phoneTf.text]) {
        [MBProgressHUD showTipMessageInView:@"请输入正确的手机号"];
        return;
    }
    
    if (![PatternHelper validatePassword:self.passwordTf.text]) {
        [MBProgressHUD showTipMessageInView:@"请输入6-30位格式的密码"];
        return;
    }
    
    NSDictionary *params = @{@"phone":self.phoneTf.text,@"password":self.passwordTf.text};
    [FXHttpTool postWithURL:@"loginUser" params:params sucess:^(id json) {
        id result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",result);
        
        if ([result[@"code"] integerValue] == 200) {
            
            NSDictionary *dict = result;
            UserInfo *info = [UserInfo modelWithDictionary:dict];
            [UserInfoManager saveAccount:info];
            kAppWindow.rootViewController = [[MainTabBarController alloc] init];
        }

        [MBProgressHUD showTipMessageInView:result[@"msg"]];
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
   
    
    

    
}

#pragma mark ---- 注册
-(void)registerAction {
    DLog(@"注册");
    RegisterViewController *registerAccount = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerAccount animated:YES];
    
}

#pragma mark ---- 忘记密码
-(void)forgetAction {
    DLog(@"忘记密码");
    ForgetPasswordController *forget = [[ForgetPasswordController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
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

-(UITextField *)passwordTf {
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.textAlignment = NSTextAlignmentLeft;
        _passwordTf.keyboardType = UIKeyboardTypeDefault;
        _passwordTf.font = kAdaptedFontSize(kAdaptedWidth(17));
        _passwordTf.placeholder = @"请输入密码";
        _passwordTf.secureTextEntry = YES;
        _passwordTf.inputAccessoryView = [self addToolbar];
    }
    return _passwordTf;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
