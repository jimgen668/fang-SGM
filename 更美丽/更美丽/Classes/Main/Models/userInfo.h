//
//  userInfo.h
//  更美丽
//
//  Created by tarena06 on 16/4/5.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfo : NSObject

/** nickname*/
@property(nonatomic,copy)NSString *nickname;

/**图像名 */
@property(nonatomic,copy)NSString *avatar;

/**用户等级 */
@property(nonatomic,copy)NSString*level_name;

/**用户所发消息*/
@property(nonatomic,copy)NSString*title;

/**用户所发图片 */
@property(nonatomic,strong)NSArray*pic;

/** 点赞数*/
@property(nonatomic,copy)NSString*praise_num;

/** 评论数*/
@property(nonatomic,copy)NSString*comment_num;

/**时间 */
@property(nonatomic,copy)NSString*time;


+(id)parserUserInfoJson:(NSDictionary*)userInfoDict;

/** 解析图片数组*/
+(NSArray*)parserPicInfoJson:(NSArray*)userPicDict;



@end
