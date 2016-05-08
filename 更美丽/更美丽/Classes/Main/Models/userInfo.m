//
//  userInfo.m
//  更美丽
//
//  Created by tarena06 on 16/4/5.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo

+(id)parserUserInfoJson:(NSDictionary *)userInfoDict
{
    return [[self alloc]initWithUserInfoDict:userInfoDict];

}

-(id)initWithUserInfoDict:(NSDictionary*)userInfoDict
{
    if (self = [super init]) {
        
        self.nickname = userInfoDict[@"nickname"];
        self.avatar = userInfoDict[@"avatar"];
        self.level_name = userInfoDict[@"level_name"];
        self.title = userInfoDict[@"title"];
        self.praise_num = userInfoDict[@"praise_num"];
        self.comment_num = userInfoDict[@"comment_num"];
        self.time = userInfoDict[@"time"];
        self.pic = userInfoDict[@"pic"];
    }

    return self;
}

+(NSArray *)parserPicInfoJson:(NSArray *)picDict
{
    return [[self alloc] parserUserPic:picDict];
  
}

-(NSArray*)parserUserPic:(NSArray*)picDict
{
    self.pic = picDict;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *pic in self.pic) {
        
        NSString *content = pic[@"content"];
        [mutableArray addObject:content];
    }
    return  [mutableArray copy];
}



@end
