//
//  UIImageView+roundImageView.m
//  更美丽
//  Created by hello on 16/3/30.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "UIImageView+roundImageView.h"

@implementation UIImageView (roundImageView)

-(void)setUPRoundImageView
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
}



@end
