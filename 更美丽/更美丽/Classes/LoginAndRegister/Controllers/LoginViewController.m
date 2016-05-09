//  LoginViewController.m
//  更美丽
//  Created by hello on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "LoginViewController.h"
#import "UerInfo.h"
#import "XMPPTool.h"

@interface LoginViewController ()

/** 提示label*/
@property (weak, nonatomic) IBOutlet UITableViewCell *showLabel;
/**登录Cell */
@property (weak, nonatomic) IBOutlet UITableViewCell *loginCell;
/** 登录名 */
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
/**登录密码 */
@property (weak, nonatomic) IBOutlet UITextField *loginPwdTextField;
/** 登录方法*/
- (IBAction)loginBtnClick:(id)sender;
/** 忘记密码*/
- (IBAction)forgottenPwd:(id)sender;
/** 注册协议*/
- (IBAction)loginProtocol:(id)sender;


@end



@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

//组数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"logincell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifer];
    switch (indexPath.row) {
        case 0:
            return self.showLabel;
        case 1:
            return self.loginCell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 44;
    }
    else
    {
        return 170;
    }
}

//登录方法
- (IBAction)loginBtnClick:(id)sender {
    
//    if (self.loginNameTextField.text.length == 11 && self.loginPwdTextField.text.length >5) {
    
       UerInfo *userInfo = [UerInfo  shareSingelInstace];
        userInfo.isLogin = YES;
       userInfo.userLoginName =  self.loginNameTextField.text;
       userInfo.userLoginPwd  =  self.loginPwdTextField.text;
    
         NSLog(@"执行登录的方法");
        //调用xmpp工具类实现登录逻辑
        [[XMPPTool sharedXMPPTool] userLogin:^(XMPPToolType type) {
            switch (type) {
                case XMPPToolTypeLoginSuccess:
                    NSLog(@"登录成功");
                {

                    [self.navigationController popViewControllerAnimated:YES];
                }
                   break;
                case XMPPToolTypeLoginFailed:
                    NSLog(@"登录失败");
                    break;
                case XMPPToolTypeError:
                    NSLog(@"连接失败");
        
                default:
                    break;
            }
            
        }];
    }

//    else
//    {
//        NSLog(@"请确定手机号码或密码后再登录");
//        return;
//    }
//}

//找回密码
- (IBAction)forgottenPwd:(id)sender {
    
    NSLog(@"找回密码");
}

//进入登录协议
- (IBAction)loginProtocol:(id)sender {
    
    NSLog(@"进入登录协议");
}

-(void)dealloc
{
    NSLog(@"销毁%@",self);
}


@end
