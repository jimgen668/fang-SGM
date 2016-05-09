//
//  UserPublishInfoTableViewCell.m
//  更美丽
//
//  Created by hello on 16/3/11.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "UserPublishInfoTableViewCell.h"

@interface UserPublishInfoTableViewCell ()

/** 发消息*/
@property (weak, nonatomic) IBOutlet UILabel *pubulishMessageLabel;
/** 发消息的时间*/
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
/**点赞按钮*/
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn;
/**评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/**发布消息距离左边缘距离 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingToLeftView;

@end

@implementation UserPublishInfoTableViewCell






@end
