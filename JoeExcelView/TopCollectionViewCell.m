//
//  TopCollectionViewCell.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "TopCollectionViewCell.h"

@implementation TopCollectionViewCell
@synthesize topTextLab;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        topTextLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        topTextLab.backgroundColor = [UIColor clearColor];
        topTextLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:topTextLab];
        
        UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(topTextLab.frame.size.width-1, 0, 1, self.contentView.frame.size.height)];
        vLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:vLineView];
        
        UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1)];
        hLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:hLineView];
        
    }
    return self;
}


@end
