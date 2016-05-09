//
//  UserPicCollectionViewCell.m
//  更美丽
//
//  Created by hello on 16/4/8.
//  Copyright © 2016年 cn. All rights reserved.
//

#import "UserPicCollectionViewCell.h"

@implementation UserPicCollectionViewCell


-(void)setBgImageView:(UIImageView *)bgImageView
{
    _bgImageView = bgImageView;
    _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:_bgImageView];
//    [self.layer addSublayer:_bgImageView.layer];

}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.bgImageView.frame = self.frame;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];


}







@end
