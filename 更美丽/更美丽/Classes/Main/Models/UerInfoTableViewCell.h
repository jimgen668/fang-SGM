//
//  UerInfoTableViewCell.h
//  更美丽
//  Created by hello on 16/3/9.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userInfo.h"


@interface AFIndexedCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface UerInfoTableViewCell : UITableViewCell

//存储用户信息
@property(nonatomic,strong)NSArray*userData;
/** 用户图像*/
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
/** 网名*/
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 用户等级*/
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
/** 用户所发消息*/
@property (weak, nonatomic) IBOutlet UILabel *userShareDetailMsgLable;
/** 展示用户图片*/
@property (weak, nonatomic) IBOutlet UICollectionView *userShareCollectionView;
/** 发消息时间*/
@property (weak, nonatomic) IBOutlet UILabel *userSendMsgTimeLable;
/** 点击关注 */
@property (weak, nonatomic) IBOutlet UIButton *userNoticeBtn;
/** 评论*/
@property (weak, nonatomic) IBOutlet UIButton *userCommentBtn;
/**用户所用信息属性*/
@property(nonatomic,strong)userInfo*usrInfo;
/** 存储用户所发图片*/
@property(nonatomic,strong)NSArray*userPicArray;

@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

/** 每一个cell对应的图片数组*/
@property(nonatomic,strong)NSArray *perCellPicArray;


//返回所有userInfo类数据
+(NSArray*)detailCellFromUserInfo;
//-(instancetype)init;

+(NSArray*)usrPic;


- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
