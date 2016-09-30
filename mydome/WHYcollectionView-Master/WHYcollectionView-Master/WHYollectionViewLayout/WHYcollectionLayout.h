//
//  WHYcollectionLayout.h
//  WHYcollectionView-Master
//
//  Created by 吴昊原 on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHYcollectionViewDelegate <NSObject>

-(CGFloat)colltecionViewCellHeightandIndexPath:(NSIndexPath*)indexPath;

@end
@interface WHYcollectionLayout : UICollectionViewLayout

@property(nonatomic,assign)CGFloat  WHYDefaultRowMargin;
@property(nonatomic,assign)NSInteger  WHYDefaultColums;
@property(nonatomic,assign)CGFloat  WHYDefaultColumsMargin;
@property(nonatomic,assign)UIEdgeInsets  WHYdefultinsets;
@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)id<WHYcollectionViewDelegate>delegate;
@end
