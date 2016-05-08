//
//  UerCountTableViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/11.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "UerCountTableViewController.h"
#import "PersonalInfoTableViewController.h"
#import "PersonalPhotoTableViewController.h"
#import "LoginViewController.h"
#import "UerInfo.h"

@interface UerCountTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *friendCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *personalPhotoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *collectionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *settingCell;



@end

@implementation UerCountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    switch (indexPath.row) {
        case 0:
            if (indexPath.row==0) {
                return self.friendCell;
            }
        case 1:
            
                return self.personalPhotoCell;
        case 2:
                return self.collectionCell;

        default:
            return self.settingCell;
    }
    
    return cell;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

    }
    
    if (indexPath.row ==1 || indexPath.row ==2) {
        return 60;
    }
    
    switch (indexPath.row) {
        case 0:
             return 90;
        case 1:
            return 60;
        case 2:
            return 60;
            
        default:
           return 44;;
    }

}

//tableView点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==1) {
        PersonalPhotoTableViewController *vc = [PersonalPhotoTableViewController new];
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self showAlert];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"persionPhotoCell"]) {
        
        PersonalPhotoTableViewController * photo =  (PersonalPhotoTableViewController*)segue.destinationViewController;
        photo.hidesBottomBarWhenPushed = YES;
    }
}


-(void)showAlert
{
    
    //如果已经登录，返回不用登录
    if ([UerInfo sharedUerInfo].isLogin) {
        return;
    }
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未登录，是否立即登录" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *action2= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"进入登录界面");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        
        [self.navigationController pushViewController:loginViewController animated:YES];
        
    }];
    
    [alertvc addAction:action];
    [alertvc addAction:action2];
    //present
    [self presentViewController:alertvc animated:YES completion:nil];
    
}






-(void)dealloc
{
    NSLog(@"细节都是");

}





@end
