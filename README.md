> 在日常开发中经常会遇见一些官方没有给出的控件,比如下面的一个表格.要求能够上下滑动的同时左侧竖向序号也跟着滑动,左右滑动的同时顶部横向序号列也跟着滑动.

![JoeExcelView](https://user-gold-cdn.xitu.io/2019/1/24/1687dc8f9c6a58e7?w=375&h=689&f=png&s=28385)

ExcelView的思路分为三部分

## First

使用一个TableView控制底部整个控件上下滑动,左右滑动使用CollectionView来控制.

在这里我在UITableViewCell上添加了两个控件,一个负责展示左侧的竖向序号栏,这样他就能跟着TableView进行上下滑动了.

然后在UITableViewCell上添加一个UICollectionView并设置其滑动方向为横向

```[collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];```

这样整个控件基本上也就成了

## Second

这样添加完之后是可以同步的上下滑动了 但是当横向滑动的时候并不能使所有CollectionView同步移动.由于TableView和CollectionView的父类都是ScrollView那么我们利用ScrollView的代理方法

```- (void)scrollViewDidScroll:(UIScrollView*)scrollView```

来监听滑动的偏移量遍历所有可见cell上的CollectionView时期同步移动

```objective-c
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        if (scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
            return;
        }
        for (JContentTableViewCell* cell in self.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = scrollView.contentOffset;
                }
            }
            
         }
    }
}
```

完成这步 就已经完成了 左右上下同步联动...

## Third

通常我们见到的表格除了左侧一个序号列之外 顶部还有一个横向的序号条,这里横向序号条就是一个简单的UICollectionView.

添加完成之后我们同样需要处理联动的问题,在这里我使用的是KVO来监听CollectionView的偏移量然后进行联动.

```objective-c
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
```

分别给topCollectionView和jContentTableView添加Observer,然后再这两者的scrollViewDidScroll中进行setValue...

这里接不贴出代码片段了,有兴趣的可以下载源码观看...

## END

这样 整个Excel表格就简单的结束了,如果需要处理数据问题 或者didSelected跳转可以将TableVIew和CollectView的Delegate和DataSource重新代理出来再Controller中进行处理,或者重写init方法将值传进去处理(尽管这违背了MVC),源码中没有给出 ,需要用到的读者可以自行添加.