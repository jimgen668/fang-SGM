//
//  UerInfo.h
//  更美丽
//  Created by tarena06 on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface UerInfo : NSObject
singleton_interface(UerInfo)

/** 登录名*/
@property(nonatomic,copy)NSString *userLoginName;
/** 登录密码*/
@property(nonatomic,copy)NSString*userLoginPwd;

/** 注册名*/
@property(nonatomic,copy)NSString*userRegisterName;

/** 注册密码*/
@property(nonatomic,copy)NSString*userRegisterPwd;

/**区分用户是否登录 */
@property(nonatomic,assign)BOOL isLogin;

+(UerInfo*)shareSingelInstace;


@end
