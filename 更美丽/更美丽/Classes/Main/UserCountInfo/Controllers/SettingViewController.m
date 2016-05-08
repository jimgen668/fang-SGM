//
//  SettingViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *goToTheScore;

@property (weak, nonatomic) IBOutlet UITableViewCell *currentVersion;
@property (weak, nonatomic) IBOutlet UITableViewCell *helpAndAdvice;
@property (weak, nonatomic) IBOutlet UITableViewCell *clearBufferMemory;
@property (weak, nonatomic) IBOutlet UITableViewCell *exitLogin;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"settingcell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifer];
   
    switch (indexPath.row) {
        case 0:
            return self.goToTheScore;
        case 1:
            return self.currentVersion;
        case 2:
            return self.helpAndAdvice;
        case 3:
            return self.clearBufferMemory;
        case 4:
            return self.exitLogin;
            
        default:
            break;
    }
    
    return cell;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
