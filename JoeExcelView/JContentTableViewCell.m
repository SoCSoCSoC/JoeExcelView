//
//  JContentTableViewCell.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "JContentTableViewCell.h"

@implementation JContentTableViewCell
@synthesize leftTextLab;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        leftTextLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        leftTextLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:leftTextLab];
        
        UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(60-1, 0, 1, 60)];
        vLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:vLineView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60-1, self.contentView.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
