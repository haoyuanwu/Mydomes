//
//  WHYcollectionLayout.m
//  WHYcollectionView-Master
//
//  Created by 吴昊原 on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WHYcollectionLayout.h"
////默认的列数
//static NSInteger const WHYDefaultColums = 2;
////行距间隙
//static CGFloat const WHYDefaultRowMargin = 10;
////列距间隙
//static CGFloat const WHYDefaultColumsMargin = 10;
////他是一个结构体  赋值进行大括号 上左下右间距 默认的边距
//static UIEdgeInsets const WHYdefultinsets = {10,10,10,10};
@interface WHYcollectionLayout ()
//定义数字记录所有最大的Y值 以便以后比较，找出最短的列
@property(nonatomic,strong)NSMutableArray *maxCoulumnYs;
//定义数组保存所有子空间的布局对象
@property(nonatomic,strong)NSMutableArray *attrsArray;

@end

@implementation WHYcollectionLayout

//当滚动的时候会循环调用layoutAttributesForElementsInRect方法
//因为第一次调用完毕layoutAttributesForElementsInRect方法
-(NSMutableArray *)maxCoulumnYs{
    if (!_maxCoulumnYs) {
        _maxCoulumnYs = [NSMutableArray array];
        //初始化所有列的默认值
        for (int i = 0 ; i < _WHYDefaultColums ; i++) {
            //顶部间隙的默认值
            _maxCoulumnYs[i] = @(_WHYdefultinsets.top);
        }
    }
    return  _maxCoulumnYs;
}

//布局是调用
//第一次显示的时候调用
//一般情况下调用reloadData的时候调用
-(void)prepareLayout{
    [super prepareLayout];
    
    //每次计算之重置保存每一列的最大Y值得数据
    [self.maxCoulumnYs removeAllObjects];
    for (int i = 0 ; i < _WHYDefaultColums ; i++) {
        //顶部间隙的默认值
        _maxCoulumnYs[i] = @(_WHYdefultinsets.top);
    }
    
    
    
    //获取当前collectionView中有多少个子控件
    NSInteger  count = [self.collectionView numberOfItemsInSection:0];
    //利用循环创建所有子控件对应的对象
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0 ; i < count ; i++) {
        NSIndexPath *path  = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:path];
        //将属性对象添加到数组中
        [arrayM addObject:atts];
    }
    //返回存储子视图控件属性的数组
    self.attrsArray = arrayM;
    
}
//该方法用于返回collectionView上所有子视图的排布
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
   /* //每次计算之重置保存每一列的最大Y值得数据
    [self.maxCoulumnYs removeAllObjects];
    for (int i = 0 ; i < WHYDefaultColums ; i++) {
        //顶部间隙的默认值
        _maxCoulumnYs[i] = @(WHYdefultinsets.top);
    }

    //获取当前collectionView中有多少个子控件
    NSInteger  count = [self.collectionView numberOfItemsInSection:0];
    //利用循环创建所有子控件对应的对象
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0 ; i < count ; i++) {
        NSIndexPath *path  = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:path];
        //将属性对象添加到数组中
        [arrayM addObject:atts];
    }
    //返回存储子视图控件属性的数组
    return arrayM;
    */
    return self.attrsArray;
}
//用于反悔指定的子视图的布局对象
//一个UIcollectionViewLayoutAttributtes对象就对应一个子控件的排布
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建对应位置的布局对象
#warning  创建的时候不能通过alloc  init来创建布局对象的！因为如果通过alloc init来创建，系统不知道要创建的属性属于（cell 装饰视图 补充视图）
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算frame
    //宽度 = UICollectionView高度 - 左边间隙 - 右边间隙 — 中间间隙
    //总的间隙
    CGFloat totaMargin = _WHYdefultinsets.left + _WHYdefultinsets.right + (_WHYDefaultColums - 1)*_WHYDefaultColumsMargin;
    CGFloat width = (self.collectionView.frame.size.width - totaMargin)/_WHYDefaultColums;
    //高度
//    CGFloat height = 50 + arc4random_uniform(200);
   CGFloat height = [self.delegate colltecionViewCellHeightandIndexPath:indexPath];
    
    //找到最短的列数\
    以及最最短列的最大Y值
    
    //取出第0列的Y值，假设第0列的Y值最小；
    CGFloat destY = [self.maxCoulumnYs[0] doubleValue];
    NSUInteger desxtIndex = 0;
    for (int i = 1 ; i < _WHYDefaultColums; i++) {
        //取出其它列依次比较
        CGFloat tempY = [self.maxCoulumnYs[i] doubleValue];
        if (destY > tempY) {
            destY = tempY;
            desxtIndex = i;
        }
    }
    //X = 左边的边距 +（item的宽度 + 间隙） * 列号
    CGFloat x = _WHYdefultinsets.left + (width + _WHYDefaultRowMargin)* desxtIndex;

    //Y = 最短的最大的Y
    CGFloat y = destY + _WHYDefaultRowMargin;
    
    //设置子控件的位置
    attr.frame = CGRectMake(x, y, width, height);
    
    //更新当前列的Y值
    self.maxCoulumnYs[desxtIndex] = @(CGRectGetMaxY(attr.frame));
    
    return attr;
}

//返回collectionView
-(CGSize)collectionViewContentSize{
    //计算其中一列的最大的Y值
    CGFloat destY = [self.maxCoulumnYs[0] doubleValue];
    for (int i = 1 ; i < _WHYDefaultColums; i++) {
        //取出其它列依次比较
        CGFloat tempY = [self.maxCoulumnYs[i] doubleValue];
        if (destY < tempY) {
            destY = tempY;
        }
    }
    return CGSizeMake(0, destY + _WHYdefultinsets.bottom);
}

@end
