//
//  XMPPTool.h
//  更美丽
//
//  Created by tarena06 on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPFramework.h>
#import "Singleton.h"

typedef enum : NSUInteger {
    XMPPToolTypeLoginSuccess,
    XMPPToolTypeLoginFailed,
    XMPPToolTypeError,
    XMPPToolTypeRegisterSuccess,
    XMPPToolTypeRegisterFailed,
    
} XMPPToolType;

typedef void(^XMPPToolBlock)(XMPPToolType type);

@interface XMPPTool : NSObject
singleton_interface(XMPPTool)
/**xmppStream流 */
@property(nonatomic,strong)XMPPStream *xmppStream;

/**设置电子名片模块 和头像*/

/** 登录方法*/
-(void)userLogin:(XMPPToolBlock)block;

/**注册方法 */
-(void)userRegister:(XMPPToolBlock)block;


@end








