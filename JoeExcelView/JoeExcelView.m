//
//  JoeExcelView.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "JoeExcelView.h"
#import "JContentTableView.h"
#import "TopCollectionView.h"
#import "JContentTableViewCell.h"
#import "JoeExcel.h"

@interface JoeExcelView ()

@property (nonatomic, strong) JContentTableView *jContentTableView;
@property (nonatomic, strong) TopCollectionView *topCollectionView;

@end


@implementation JoeExcelView
@synthesize jContentTableView;
@synthesize topCollectionView;


#warning -- 如果想在类外面处理ContentTableView和TopCollectionView可以将他们的Delegate和DataSource代理出来 例如JContentTableView中CollectionView的didSelected方法...
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor orangeColor];
        lab.text = @"JoeExcelView";
        [self addSubview:lab];
        
        UILabel *vNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, lab.frame.size.height, 60, 30)];
        vNumLab.backgroundColor = [UIColor yellowColor];
        vNumLab.textAlignment = NSTextAlignmentCenter;
        vNumLab.text = @"num";
        [self addSubview:vNumLab];
        
        // 顶部横向序号CollectionView
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        topCollectionView = [[TopCollectionView alloc] initWithFrame:CGRectMake(vNumLab.frame.size.width, lab.frame.size.height, frame.size.width-vNumLab.frame.size.width, 30) collectionViewLayout:collectionViewFlowLayout];
        topCollectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:topCollectionView];
        
        // 添加Observer
        [topCollectionView addObserver:self forKeyPath:TopCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        jContentTableView = [[JContentTableView alloc] initWithFrame:CGRectMake(0, vNumLab.frame.size.height+vNumLab.frame.origin.y, self.frame.size.width, self.frame.size.height-vNumLab.frame.size.height-lab.frame.size.height) style:UITableViewStylePlain];
        [self addSubview:jContentTableView];
        
        // 添加Observer
        [jContentTableView addObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

// 不做容错处理crash
- (id)valueForUndefinedKey:(NSString *)key{
    return @"TopCollectionViewObserver";
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    
    if ([keyPath isEqualToString:TopCollectionViewObserver]) {
        for (JContentTableViewCell* cell in jContentTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = topCollectionView.contentOffset;
                    
                }
            }
        }
    }
    
    if ([keyPath isEqualToString:JContentTableViewCellCollectionViewObserver]) {
        for (JContentTableViewCell *cell in jContentTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    topCollectionView.contentOffset = collectionView.contentOffset;
                    
                }
            }
        }
    }
}

// 移除Observer
- (void)dealloc{
    [topCollectionView removeObserver:self forKeyPath:TopCollectionViewObserver];
    [jContentTableView removeObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver];
}




@end
