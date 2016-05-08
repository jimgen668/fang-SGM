//
//  UerInfoTableViewCell.m
//  更美丽
//  Created by tarena06 on 16/3/9.
//  Copyright © 2016年 cn. All rights reserved.
//


#import "UerInfoTableViewCell.h"
#import "UIImageView+roundImageView.h"
#import "UserInfoParese.h"
#import "userInfo.h"
#import <SBJson.h>



@implementation AFIndexedCollectionView

@end

@interface UerInfoTableViewCell ()

@property(nonatomic,strong)NSArray *userInfoArray;

@property (weak, nonatomic) IBOutlet UIView *view;




@end

@implementation UerInfoTableViewCell


//设置圆形图像
-(void)setUserIconImageView:(UIImageView *)userIconImageView
{
    _userIconImageView = userIconImageView;
    
    [_userIconImageView  setUPRoundImageView];
}


//返回所用userInfo类对象数组
+(NSArray *)detailCellFromUserInfo
{
    NSString *urlStr = @"http://app.hgzrt.com/index.php?m=app&c=homepage&a=init&deviceid=1457341251848736638700883A0B4C&os=1&v=1.0.2&name=sgm&os_v=8.00&devicename=iPhone4,1&username=iphone4s&w=22.567185&j=113.863516&page=1&pagesize=20";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error = nil;
    NSString *jsonStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dict = [parser objectWithString:jsonStr];

    NSArray *array = [UserInfoParese pareseUserInfoWithResponseObject:dict];
    
    return [array copy];
}

//重写usrInfo的Setter方法
-(void)setUsrInfo:(userInfo *)usrInfo
{
    _usrInfo = usrInfo;
    self.userNameLabel.text = self.usrInfo.nickname;
    NSString *imageName = self.usrInfo.avatar;
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *imageData = [NSData  dataWithContentsOfURL:url];
    self.userIconImageView.image = [UIImage imageWithData:imageData];
    self.userLevelLabel.text = self.usrInfo.level_name;
    self.userShareDetailMsgLable.text = self.usrInfo.title ;
    self.userSendMsgTimeLable.text = self.usrInfo.time;
    self.userNoticeBtn.titleLabel.text = self.usrInfo.praise_num;
    self.userCommentBtn.titleLabel.text = self.usrInfo.comment_num;
    /**用户图片数组*/
    self.userPicArray =  [userInfo parserPicInfoJson:self.usrInfo.pic];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        return nil;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
    layout.itemSize = CGSizeMake(50, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.userShareCollectionView = self.collectionView;
    [self.contentView addSubview:self.collectionView];

    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView reloadData];
}



@end









