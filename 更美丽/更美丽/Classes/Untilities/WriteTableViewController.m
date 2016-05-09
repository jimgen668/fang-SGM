//
//  WriteTableViewController.m
//  更美丽
//
//  Created by hello on 16/3/9.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "WriteTableViewController.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import "LoginViewController.h"
#import "UerInfo.h"

@interface WriteTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;

@property (weak, nonatomic) IBOutlet UITextView *sendMsgTextView;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *enditBtn;

@property(nonatomic)BOOL isEditing;

//sendView到右侧的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightViewToSendView;

@property (weak, nonatomic) IBOutlet UIView *rightView;

//是否自己可见
@property (weak, nonatomic) IBOutlet UISwitch *isPrivateSaw;

//alertViewController
@property(nonatomic,strong)UIAlertController * alertController;


@end

@implementation WriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
     //默认隐藏
     self.rightView.hidden = YES;
     self.RightViewToSendView.constant  =10;
    
    //添加手势
    self.addImageView.userInteractionEnabled = YES;
    [self.addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPhotos)]];
 
     UIBarButtonItem* left=[[UIBarButtonItem alloc]initWithTitle:self.titleStr style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];

     self.navigationItem.leftBarButtonItem = left;
     NSLog(@"%@",self.titleStr);

     
    
}

-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
     //弹出是否登录对话框
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

-(void)goBack
{

     [self.navigationController  popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    switch (indexPath.row)
    {
        case 0:
            return  self.firstCell;
            
        default:
            return   self.secondCell;
    }
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"进入编辑模式");
    }
}

//点击编辑的方法
- (IBAction)editingBtnClick:(id)sender {
    

    self.isEditing = !self.isEditing;
    //ok模式
    if (self.isEditing) {
         
        [self.enditBtn setTitle:@"ok" forState:UIControlStateNormal];
         self.enditBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [self.tableView setEditing:YES animated:YES];
         self.rightView.hidden = NO;
         self.RightViewToSendView.constant= 30;
    }
    //编辑模式
    else
    {
        [self.enditBtn setTitle:@"编辑" forState:UIControlStateNormal];
         self.rightView.hidden = YES;
         self.RightViewToSendView.constant= 5;
         [self.tableView setEditing:NO animated:YES];
    }
}

-(void)addPhotos
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片选取" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
      else
      {
           UILabel *label = [[UILabel alloc]init];
           label.text = @"调用相机错误";
           [MBProgressHUD showHUDAddedTo:label animated:YES];
      }
         
    }];

    //选取相册方法
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
         UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
         imagePicker.delegate = self;
         imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         imagePicker.allowsEditing = YES;
         [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cameraAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
//    UIActionSheet *actionSheet = [[UIActionSheet  alloc]initWithTitle:@"图片选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
//    [actionSheet showInView:self.view];
    
}

#pragma  mark -UIImagePickerControllerDelegate协议
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
     UIImage *image = info[UIImagePickerControllerEditedImage];
     self.addImageView.image = image;
     [self dismissViewControllerAnimated:YES completion:nil];

}

//完成加载图片 文字 上传到服务器
- (IBAction)finishLoadInfo:(id)sender {
     
//     AFHTTPSessionManager * manager  = [AFHTTPSessionManager manager];
//     
//     manager POST:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>
     
     
     
     
}

-(void)dealloc
{
    NSLog(@"self=%@",self);
}








@end
