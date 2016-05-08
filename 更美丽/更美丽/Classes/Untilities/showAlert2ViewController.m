//
//  showAlert2ViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/21.
//  Copyright © 2016年 cn. All rights reserved.
//
//
//#import "showAlert2ViewController.h"
//#import "LoginViewController.h"
//#import "UerInfo.h"
//
//@interface showAlert2ViewController ()
//
//@end
//
//@implementation showAlert2ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//+(instancetype)showAlertWithClass:(Class)currentClass
//{
//    
//    //如果已经登录，返回不用登录
//    if ([UerInfo sharedUerInfo].isLogin) {
//        return nil;
//    }
//    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未登录，是否立即登录" preferredStyle:UIAlertControllerStyleAlert];
//    
//    
//    UIAlertAction *action  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        NSLog(@"取消");
//        [cu dismissViewControllerAnimated:YES completion:nil];
//        
//    }];
//    UIAlertAction *action2= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        NSLog(@"进入登录界面");
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
//        
//        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
//        
//        [self.navigationController pushViewController:loginViewController animated:YES];
//        
//    }];
//    
//    [alertvc addAction:action];
//    [alertvc addAction:action2];
//    //present
//    [self.n presentViewController:alertvc animated:YES completion:nil];
//
//}
//
//
//@end






