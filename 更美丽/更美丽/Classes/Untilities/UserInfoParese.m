//
//  UserInfoParese.m
//  更美丽
//  Created by hello on 16/4/1.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "UserInfoParese.h"
#import <AFNetworking.h>
#import "UerInfoTableViewCell.h"
#import "userInfo.h"

@interface UserInfoParese ()

@property(nonatomic,weak)NSMutableArray *mutableArray;

@end

@implementation UserInfoParese

+(NSArray *)pareseUserInfoWithUrl:(NSString *)url
{
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = [NSDictionary dictionary];
    
    __weak NSMutableArray *mutableArray = [NSMutableArray array];

  [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
      
      NSLog(@"进度%@",downloadProgress);
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSLog(@"服务器响应成功返回的对象%@",responseObject);
//      NSDictionary *dict = [NSDictionary dictionary];
//      
//      for (dict in responseObject) {
//          UerInfoTableViewCell *userCell = [UerInfoTableViewCell new];
//          [userCell setValuesForKeysWithDictionary:dict];
//          [mutableArray addObject:userCell];
//      }
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"错误信息%@",error);
  }];
    
    return [mutableArray copy];
}

+(NSArray *)pareseUserInfoWithResponseObject:(id)responseObject

{
    NSArray *blogListArray = responseObject[@"data"][@"blog"][@"blog_list"];
    
    NSMutableArray *mutableArray = [NSMutableArray  array];
    
    for (NSDictionary *blogDict in blogListArray)
    {
        userInfo * usrDetail = [userInfo  parserUserInfoJson:blogDict];
//        [usrDetail setValuesForKeysWithDictionary:blogDict];
        [mutableArray addObject:usrDetail];
    }
    
    return [mutableArray copy];
}

@end






