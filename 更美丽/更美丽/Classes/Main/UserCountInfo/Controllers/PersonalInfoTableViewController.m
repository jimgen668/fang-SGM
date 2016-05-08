//
//  PersonalInfoTableViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/11.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "PersonalInfoTableViewController.h"
#import "PersonalPhotoTableViewController.h"

@interface PersonalInfoTableViewController ()

/** 头像*/
@property (weak, nonatomic) IBOutlet UITableViewCell *headImageCell;
/**昵称 */
@property (weak, nonatomic) IBOutlet UITableViewCell *nickNameCell;
/** ID*/
@property (weak, nonatomic) IBOutlet UITableViewCell *IDNumberCell;
/**手机号码 */
@property (weak, nonatomic) IBOutlet UITableViewCell *telPhoneCell;
/** 等级*/
@property (weak, nonatomic) IBOutlet UITableViewCell *levelCell;
/** 积分*/
@property (weak, nonatomic) IBOutlet UITableViewCell *scoreCell;
/**性别 */
@property (weak, nonatomic) IBOutlet UITableViewCell *genderCell;
/** 地区*/
@property (weak, nonatomic) IBOutlet UITableViewCell *areaCell;
/** 个性签名*/
@property (weak, nonatomic) IBOutlet UITableViewCell *personalSignCell;



@end

@implementation PersonalInfoTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 2;
        default:
            return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    switch (indexPath.section) {
        case 0:
                return self.headImageCell;
        case 1:
            
            if (indexPath.row == 0)
                return self.nickNameCell;
            else if(indexPath.row == 1)
                return self.IDNumberCell;
            else if (indexPath.row == 2)
                return  self.telPhoneCell;
        case  2:
            if (indexPath.row == 0) {
                return self.levelCell;
            }
            else if (indexPath.row == 1)
            {
                return self.scoreCell;
            }
       case 3 :
            
            if (indexPath.row == 0) {
                return self.genderCell;
            }
            else if(indexPath.row == 1)
            {
                return self.areaCell;
            }
            else if(indexPath.row == 2)
            {
                return self.personalSignCell;
            }
            
        default:
            return nil;
    }
    
    
    return cell;
}

- (IBAction)goBackToUserCountVC:(id)sender {
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}


-(void)dealloc
{
    NSLog(@"销毁%@",self);
}












/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
