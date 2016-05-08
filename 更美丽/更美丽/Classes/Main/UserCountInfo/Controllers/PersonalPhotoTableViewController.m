//
//  PersonalPhotoTableViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/11.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "PersonalPhotoTableViewController.h"
#import "WriteTableViewController.h"
#import "UIImageView+roundImageView.h"

@interface PersonalPhotoTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

@implementation PersonalPhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.headerImageView setUPRoundImageView];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(goToWrite)];
    UIBarButtonItem *leftTitle = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *leftArrow = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbutton2"] style:UIBarButtonItemStylePlain target:nil action:nil];
    leftArrow.imageInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    self.navigationItem.leftBarButtonItems = @[leftArrow,leftTitle];
    //
    
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"backPush"]) {
        
        WriteTableViewController *wc = (WriteTableViewController*)segue.destinationViewController;
        
        wc.titleStr = @"返回";
        wc.leftImageStr = @"backbutton2";
        
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

#warning ToDo 假定为1
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    
    
    return cell;
}



@end
