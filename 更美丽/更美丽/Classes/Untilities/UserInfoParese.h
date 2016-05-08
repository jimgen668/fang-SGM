//
//  UserInfoParese.h
//  更美丽
//
//  Created by tarena06 on 16/4/1.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoParese : NSObject

/** url -> NSArray 从网络中获取*/
+(NSArray*)pareseUserInfoWithUrl:(NSString*)url;

/** dict -> NSArray 从本地解析*/

+(NSArray*)pareseUserInfoWithResponseObject:(id)responseObject;


@end
