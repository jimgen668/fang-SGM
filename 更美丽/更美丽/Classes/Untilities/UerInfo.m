//
//  UerInfo.m
//  更美丽
//
//  Created by tarena06 on 16/3/13.
//  Copyright © 2016年 cn. All rights reserved.

#import "UerInfo.h"

@implementation UerInfo
singleton_implementation(UerInfo)

static UerInfo *userInfo = nil;

+(UerInfo*)shareSingelInstace
{
   static dispatch_once_t predicate;
   dispatch_once(&predicate, ^{
      userInfo = [[UerInfo alloc]init];

   });
    
    return userInfo;

}






@end
