//
//  ViewController.m
//  WHYcollectionView-Master
//
//  Created by 吴昊原 on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
static NSString *clcellID = @"cellid";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WHYcollectionViewDelegate>
{
    NSMutableArray *imageArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout *fowlayout = [[UICollectionViewFlowLayout alloc]init];
    WHYcollectionLayout *layout = [[WHYcollectionLayout alloc]init];
    layout.delegate = self;
    layout.WHYDefaultColums = 2;
    layout.WHYDefaultRowMargin = 10;
    layout.WHYDefaultColumsMargin = 10;
    layout.WHYdefultinsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    imageArray = [[NSMutableArray alloc] initWithCapacity:30];
    for (int i = 1; i < 17 ; i++) {
        [imageArray addObject:[NSString stringWithFormat:@"images.bundle/test_%d",i]];
    }
    
    UICollectionView *clView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    clView.delegate = self;
    clView.dataSource = self;

    [clView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:clcellID];
    
    [self.view addSubview:clView];

}

-(CGFloat)colltecionViewCellHeightandIndexPath:(NSIndexPath*)indexPath{
    UIImage *image = [UIImage imageNamed:imageArray[indexPath.row]];
    CGSize size = image.size;
    
    return size.height;
}


-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:clcellID forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
