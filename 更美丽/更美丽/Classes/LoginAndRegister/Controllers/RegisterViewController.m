//
//  RegisterViewController.m
//  更美丽
//
//  Created by hello on 16/3/15.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "UerInfo.h"
#import "XMPPTool.h"
#import <SVProgressHUD.h>

@interface RegisterViewController ()

/**注册手机号码 */
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneNumber;

/** 注册密码*/
@property (weak, nonatomic) IBOutlet UITextField *registerPhonePwd;
/** 获取验证码*/
@property (weak, nonatomic) IBOutlet UIButton *confirmedBtn;

/** 输入验证码*/
@property (weak, nonatomic) IBOutlet UITextField *confirmedTextField;

/** 注册点击*/
- (IBAction)registerBtnClick:(id)sender;

/**定时器 */
@property(nonatomic,strong)NSTimer *timer;

/** 事件*/
@property(nonatomic,assign)NSInteger count;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 点击获取验证码方法*/
- (IBAction)confirmedBtnClick:(id)sender {
    
    //注册名密码非空判断
    if (self.registerPhoneNumber.text.length == 0 || self.registerPhonePwd.text.length == 0) {
        
        NSLog(@"注册名或密码不能为空");
      [SVProgressHUD showErrorWithStatus:@"注册名或密码不能为空"];
        return ;
    }
//    self.count = 5;
//    self.confirmedBtn.userInteractionEnabled = YES;
//    
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    //获得验证码
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.registerPhoneNumber.text  zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"获取验证码成功");
//            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
//        }
//        else
//        {
////            NSLog(@"错误信息:%@",error);
//        }
//    }];

}
//-(void)reduceTime
//{
//
//
//    if (self.count == 0) {
//     [self.confirmedBtn setTitle:@"请输入验证码" forState:UIControlStateNormal];
//        [self.timer invalidate];
//        self.timer = nil;
//        self.confirmedBtn.userInteractionEnabled = YES;
//    }
//    else
//    {
//      self.count --;
//    [self.confirmedBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.count] forState:UIControlStateNormal];
//        self.confirmedBtn.userInteractionEnabled = NO;
//        
//    }
//    
//    
//}

/**注册点击事件 */
- (IBAction)registerBtnClick:(id)sender {
    
    if (self.confirmedTextField.text ==nil) {
        NSLog(@"验证码不能为空");
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }
   //提交验证码
//    [SMSSDK commitVerificationCode:self.confirmedTextField.text phoneNumber:self.registerPhoneNumber.text zone:@"86" result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"验证成功");
           //注册逻辑
            UerInfo *userInfo = [UerInfo sharedUerInfo];
            userInfo.userRegisterName = self.registerPhoneNumber.text;
            userInfo.userRegisterPwd = self.registerPhonePwd.text;
           [[XMPPTool sharedXMPPTool] userRegister:^(XMPPToolType type) {
              
               switch (type) {
                   case XMPPToolTypeRegisterSuccess:
                       NSLog(@"注册成功");
                       
                       break;
                   case XMPPToolTypeRegisterFailed:
                       NSLog(@"注册失败");
                       break;
                   case XMPPToolTypeError:
                       
                       break;
                       
                   default:
                       break;
               }
               
           }];
            
//        }
//        else
//        {
//            NSLog(@"验证码错误%@",error);
//        }
//    }];

}


-(void)dealloc
{
    NSLog(@"销毁%@",self);

}



@end
