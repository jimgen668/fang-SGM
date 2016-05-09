//
//  HomeTableViewController.m
//  更美丽
//  Created by hello on 16/3/9.
//  Copyright © 2016年 cn. All rights reserved.
//
/** 
 主要疑点：1.将UITableViewCell里的图片数组传递给UICollectionViewCell的图片数组中
         2.程序运行时,HomeTableViewController不走initWith方法
         3.程序运行后用户网名有些不能完全显示，屏幕适配
         4.UITableViewCell第0行选中后变为第1行
         5.未联网时运行程序崩溃
 */

#import "HomeTableViewController.h"

#import "UerInfoTableViewCell.h"
#import <MJRefresh.h>
#import "UserInfoParese.h"
#import "userInfo.h"
#import "UserPicCollectionViewCell.h"
#import "UerInfoTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "Header.h"

#import <UITableView+SDAutoTableViewCellHeight.h>

@interface HomeTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/**存放所有用户数据 */
@property(nonatomic,strong)NSArray *userDataArray;
/**存放图片数组*/
@property(nonatomic,strong)NSArray *picDataArray;
@property(nonatomic,strong)AFIndexedCollectionView *collectionView;

@property(nonatomic,strong)UerInfoTableViewCell *cell;

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
/**要显示的图片 */
@property(nonatomic,strong)UIImage *image;

/** 存储webImageUrl*/
@property(nonatomic,strong)NSURL *imageUrl;

/** cell每一行对象的图片数组*/
@property(nonatomic,strong)NSDictionary *pictureDict;

/** collectionView里图片数组*/
@property(nonatomic,strong)NSArray *collectionViewArray;

@end


@implementation HomeTableViewController

//-(instancetype)initWithStyle:(UITableViewStyle)style
//
//{
//    if (self = [super initWithStyle:style])
//    {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.sectionInset = UIEdgeInsetsMake(50, 0, 0, 50);
//        layout.itemSize = CGSizeMake(100, 100);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.minimumInteritemSpacing = 20;
//        layout.headerReferenceSize = CGSizeMake(20, 20);
//    
//        self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//         self.cell.userShareCollectionView.userInteractionEnabled = NO;
//         self.collectionView.userInteractionEnabled = NO;
//        
//        self.collectionView.backgroundColor = [UIColor whiteColor];
//        self.cell.userShareCollectionView.showsHorizontalScrollIndicator = YES;
//        self.cell.userShareCollectionView = self.collectionView;
//        [self.cell.contentView addSubview:self.cell.userShareCollectionView];
//    }
//    return self;
//}
//
//-(void)layoutSublayersOfLayer:(CALayer *)layer
//{
//    [super layoutSublayersOfLayer:layer];
//    [self.cell.layer addSublayer:self.collectionView.layer];
//}


/** 懒加载 获取用户数据数组*/
-(NSArray *)userDataArray
{
    if (!_userDataArray) {
        
        _userDataArray = [UerInfoTableViewCell detailCellFromUserInfo];
         }
                      return _userDataArray;
}


#pragma mark 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";

    [self refreshFooterAndHeader];

    //设置行高
    self.tableView.estimatedRowHeight = 240;
//    self.tableView.rowHeight =UITableViewAutomaticDimension;
    
    //注册CollectionView
    [self.cell.userShareCollectionView registerClass:[AFIndexedCollectionView  class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
}

-(void)refreshFooterAndHeader
{
    
    __weak typeof(self) weakSelf = self;
  //下拉
   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [weakSelf loadNewData];
   }];
    
  //上拉
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_footer beginRefreshing];
   
}

/** 刷新数据方法*/
- (void)loadNewData
{
    // 刷新表格
    [self.tableView reloadData];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - TableView data source

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  return self.userDataArray.count;
}
//实现自定义数据方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"homecell";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!self.cell) {
        self.cell = [UerInfoTableViewCell  new];
    }
    
    self.cell.usrInfo = self.userDataArray[indexPath.row];
    
    /** key:index value:self.cell.userPicArray
     获取每一行对应的图片数组组成的字典
//     */
//    NSInteger indexKey = indexPath.row;
//    NSArray * picArray = self.cell.userPicArray;
//    self.pictureDict = [NSDictionary  dictionaryWithObject:self.cell.userPicArray[indexPath.row] forKey:indexPath.row];
//    self.pictureDict = @{@"indexPath.row":@"self.cell.userPicArray"};
    
    //设置CollectionView的背景颜色
    self.cell.userShareCollectionView.backgroundColor = [UIColor lightGrayColor];
//    //设置CollectionView的代理
    self.cell.userShareCollectionView.delegate = self;
    self.cell.userShareCollectionView.dataSource = self;
    [self.cell.userShareCollectionView addSubview: self.collectionView];
    
//    self.collectionView.delegate =  self;
//    self.collectionView.dataSource = self;
    
    /**获取每一一个cell的对应的图片数组；*/
    return self.cell;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中第%ld行",indexPath.row);
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UerInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
//    NSInteger index = cell.collectionView.tag;
//    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
//    [self.cell.userShareCollectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
//
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    id model = self.userDataArray[indexPath.row];
//    
//    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath: @"model" cellClass:[UerInfoTableViewCell class] contentViewWidth:[self cellContentViewWith]];
//
//
//}
//- (CGFloat)cellContentViewWith
//
//{
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        
//        // 适配ios7
//        if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//            width = [UIScreen mainScreen].bounds.size.height;
//        }
//        return width;
//}

#pragma  mark  - UICollectionViewDelegate
/**分区 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    /**
     图片3张之内   section = 1
       3<count<=6  section = 2
       6<couny< = 9 section = 3;
     */
    if (self.cell.userPicArray.count < 9 &&self.cell.userPicArray.count>=6) {
        return 3;
    }
    else if (self.cell.userPicArray.count < 6&&self.cell.userPicArray.count >3)
    
    {
        return 2;
    }
   else
   {
       return 1;
   }
}

/**分行*/
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.userDataArray.count > 3) {
        return 3;
    }
    else
    {
        return self.userDataArray.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserPicCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
//    NSArray *array = self.cell.userPicArray;
//    for (NSString *imageName in array) {
////        NSString *imageStr = [imageName ];
//        //字符串转换 jpg -> png
//        NSURL *url = [NSURL URLWithString:imageName];
//        
//        self.imageUrl = url;
//    }
//    collectionCell.bgImageView.image = [UIImage imageNamed:@"checkBoxMaleYes"];
    
    
    //网络图片下载
//    [collectionCell.bgImageView sd_setImageWithURL: self.imageUrl placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:collectionCell.bounds];
    
    [imageView sd_setImageWithURL:self.imageUrl placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [collectionCell.contentView addSubview:imageView];
    
//    cell的颜色
    collectionCell.backgroundColor = [UIColor whiteColor];
    
    return collectionCell;

}

//指定Cell的尺寸
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return CGSizeMake(80,80);
//}
//设定collectionView(指定区)的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,0,0);
}

-(void)dealloc
{
    self.collectionView.delegate = nil;
    NSLog(@"销毁%@",self);
    
}







@end
