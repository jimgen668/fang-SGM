//
//  QuestionTableViewController.m
//  更美丽
//
//  Created by tarena06 on 16/3/10.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "QuestionTableViewController.h"
#import "LoginViewController.h"
#import "UerInfo.h"

@interface QuestionTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *phoneNumberCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *ageCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *genderCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *photoAndTextCell;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewToViewTrailing;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property (weak, nonatomic) IBOutlet UIImageView *addPhotoImageView;

@property (weak, nonatomic) IBOutlet UIButton *editingBtn;

@property (weak, nonatomic) IBOutlet UIButton *femailBtn;

@property (weak, nonatomic) IBOutlet UIButton *mailBtn;

@property (weak, nonatomic) IBOutlet UITextView *msgTetView;

@end

@implementation QuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textViewToViewTrailing.constant = 5.0;
    self.editing = NO;
    self.rightImageView.hidden = YES;
    
    //默认设置用户交互
    self.addPhotoImageView.userInteractionEnabled = YES;
    self.addImageView.userInteractionEnabled = YES;
    
    //完成按钮
     self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishWriting)];
}

//完成图片信息上传
-(void)finishWriting
{
    if (self.msgTetView.text == nil ||self.nameCell.textLabel.text == nil)
    {
        NSLog(@"请输入内容");
        return ;
    }
    //上传方法
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //判断是否登录
    [self showAlert];
    
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


- (IBAction)editingBtnClick:(id)sender {
    
    self.editing = !self.editing;
    if (self.editing) {
        [self.editingBtn setTitle:@"ok" forState:UIControlStateNormal];
        self.editingBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        self.textViewToViewTrailing.constant = 30.0;
        self.rightImageView.hidden = NO;
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        [self.editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.textViewToViewTrailing.constant = 5.0;
        self.rightImageView.hidden = YES;
        [self.tableView setEditing:NO animated:YES];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    
    switch (indexPath.row) {
        case 0:
            return self.nameCell;
        case 1:
            return self.phoneNumberCell;
        case 2:
            return self.ageCell;
        case 3:
            return self.genderCell;
        default:
           
            [self.addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPhoto)]];
            [self.addPhotoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPhoto)]];
            
           return self.photoAndTextCell;
    }
    
    return cell;
}

-(void)addPhoto
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片选取" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //调用相机
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc]init];
        if (pickerImage.sourceType == UIImagePickerControllerSourceTypeCamera ) {
            
            pickerImage.delegate = self;
            
            [self presentViewController:pickerImage animated:YES completion:nil];
        }
        else
        {
            NSLog(@"该设备不支持调用相机哦");
        }
        
        
    }];
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用相册
        
    }];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [alertController addAction:actionPhoto];
    [alertController addAction:actionCancle];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma  mark - 调用相册方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.addImageView.image = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)choosenGender:(id)sender {
    
    [self.femailBtn setImage:[UIImage imageNamed:@"checkBoxFemaleNo"] forState:UIControlStateNormal];
    [self.femailBtn setImage:[UIImage imageNamed:@"checkBoxFemaleYes"] forState:UIControlStateSelected];
    [self.mailBtn setImage:[UIImage imageNamed:@"checkBoxMaleNo"] forState:UIControlStateNormal];
        [self.mailBtn setImage:[UIImage imageNamed:@"checkBoxMaleYes"] forState:UIControlStateSelected];
    self.mailBtn.selected = NO;
    self.femailBtn.selected = ! self.mailBtn.selected;
}

- (IBAction)choosenGenderMail:(id)sender {
    
    [self.femailBtn setImage:[UIImage imageNamed:@"checkBoxFemaleNo"] forState:UIControlStateNormal];
    [self.femailBtn setImage:[UIImage imageNamed:@"checkBoxFemaleYes"] forState:UIControlStateSelected];
    [self.mailBtn setImage:[UIImage imageNamed:@"checkBoxMaleNo"] forState:UIControlStateNormal];
    [self.mailBtn setImage:[UIImage imageNamed:@"checkBoxMaleYes"] forState:UIControlStateSelected];
        self.mailBtn.selected = YES;
    self.femailBtn.selected = ! self.mailBtn.selected;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==4) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}







@end
