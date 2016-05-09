//
//  XMPPTool.m
//  更美丽
//
//  Created by hello on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "XMPPTool.h"
#import "UerInfo.h"
#import "Header.h"
#import <SVProgressHUD.h>


@interface XMPPTool ()<XMPPStreamDelegate>

{
    XMPPToolBlock   _resultBlock;
}


/**设置XMPP流*/
-(void)setupXmppStream;

/** 连接到服务器*/
-(void)connectToServer;

/**发送密码,请求授权*/
-(void)sendPwdAndGetAuthor;

/**发送在线消息 */
-(void)sendOnline;

@end

@implementation XMPPTool
singleton_implementation(XMPPTool)

-(void)setupXmppStream
{
    self.xmppStream = [[XMPPStream alloc]init];
   //设置代理
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)connectToServer
{
    /** 断开之前的连接*/
    [self.xmppStream disconnect];
    if (self.xmppStream == nil) {
        [self setupXmppStream];
    }
    self.xmppStream.hostName = KRXMPPHOSTNAME;
    self.xmppStream.hostPort = KRXMPPPORT;
    
    //构建JID
    NSString * userName = nil ;
    if ([UerInfo shareSingelInstace].isLogin)
    {
        userName = [UerInfo sharedUerInfo].userLoginName;
    }
    else
    {
        userName = [UerInfo  sharedUerInfo].userRegisterName;
    }
    
    NSString *JIDStr = [NSString stringWithFormat:@"%@@%@",userName,KRXMPPDOMAIN];
    self.xmppStream.myJID = [XMPPJID jidWithString:JIDStr];
    //连接服务器
    NSError*error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error)
    {
       NSLog(@"%@",error);
    }
}

-(void)sendPwdAndGetAuthor
{
    NSString *userPwd = nil;
    NSError *error = nil;

    if ([UerInfo shareSingelInstace].isLogin) {
        userPwd = [UerInfo sharedUerInfo].userLoginPwd;
        [self.xmppStream authenticateWithPassword:userPwd error:&error];
    }
    else
    {
        userPwd = [UerInfo sharedUerInfo].userRegisterPwd;
        [self.xmppStream registerWithPassword:userPwd error:&error];
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
}

-(void)sendOnline
{
    XMPPPresence *presence = [XMPPPresence  presence];
    
    [self.xmppStream sendElement:presence];
}

#pragma  mark - XMPPStream代理方法
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"连接成功");

    [self  sendPwdAndGetAuthor];
}

-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    _resultBlock(XMPPToolTypeError);
     NSLog(@"网络连接失败");
    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"授权成功");
    if ([UerInfo sharedUerInfo].isLogin) {
        _resultBlock(XMPPToolTypeLoginSuccess);
        [self sendOnline];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];

    }
    else
    {
        _resultBlock(XMPPToolTypeRegisterSuccess);
          [self sendOnline];
    }
}

-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"授权失败");
    if (error) {
        NSLog(@"%@",error);
    }
}

-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"注册成功");
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
    _resultBlock(XMPPToolTypeRegisterSuccess);
}

-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"注册失败");
    [SVProgressHUD showErrorWithStatus:@"注册失败"];
    _resultBlock(XMPPToolTypeRegisterFailed);
    
}

//用户登录
-(void)userLogin:(XMPPToolBlock)block
{
    _resultBlock = block;
    [self connectToServer];
}
//用户注册
-(void)userRegister:(XMPPToolBlock)block
{
    _resultBlock = block;
    [self connectToServer];
}



@end
