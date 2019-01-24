//
//  ContentCollectionViewCell.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "ContentCollectionViewCell.h"

@implementation ContentCollectionViewCell
@synthesize textLab;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        textLab.backgroundColor = [UIColor clearColor];
        textLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLab];
        
        UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(textLab.frame.size.width-1, 0, 1, self.contentView.frame.size.height)];
        vLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:vLineView];
        
        UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1)];
        hLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:hLineView];
  
    }
    return self;
}
@end
