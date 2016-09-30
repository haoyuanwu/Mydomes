//
//  SearchViewController.m
//  Text  UISearchBar
//
//  Created by lanou03 on 15/6/10.
//  Copyright (c) 2015年 lanou03. All rights reserved.
//

#import "SearchViewController.h"
#import "DailyPic.h"
#import "UIImageView+WebCache.h"

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

{
    
    UICollectionView *_collectionView;
    NSMutableArray *_photoArr;
    UISearchBar *_searchBar;
    UIView *_view;
    
}
@end

@implementation SearchViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    
    }
    return self;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width *2/3,30)];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds =YES;
    _searchBar.placeholder = @"一个大傻逼";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    _searchBar.keyboardType = UIKeyboardTypeEmailAddress;
    _searchBar.showsSearchResultsButton = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width *2/3, 30)];
   
    [view addSubview:_searchBar];
    self.navigationItem.titleView = _searchBar;
    self.navigationController.navigationBar.barTintColor  = [UIColor cyanColor];
    
 
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 2;
    flowlayout.minimumInteritemSpacing = 2;

    //边界范围
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowlayout];
    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.bounces =  NO;

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"searchID"];
    [self.view addSubview:_collectionView];
    
    
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/4)];
    _view.backgroundColor = [UIColor yellowColor];
    
}

#pragma mark searchBar
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    searchBar.showsBookmarkButton = YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    _searchBar.showsScopeBar = YES;
    _searchBar.selectedScopeButtonIndex = 3;
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [_view removeFromSuperview];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    NSLog(@"========%@",searchBar.text);
    
    [_searchBar resignFirstResponder];
    
    
    
    NSString *str = [NSString stringWithFormat:@"http://client.pic.hiapk.com/index.php/3/Wallpaper/picByKeyword/word/%@/start/24/limit/24/",searchBar.text];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _urlString = urlStr;
    [self sendRequest];
    
    [_collectionView reloadData];
    
 }


#pragma mark collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{



    return _photoArr.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

 UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchID" forIndexPath:indexPath];
   
    UIImageView *imgView = [[UIImageView alloc]init];
    DailyPic *pic = _photoArr[indexPath.item];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:pic.thumbnail_img_url] placeholderImage:nil];
    cell.backgroundView = imgView;
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CGSize itemSize = CGSizeMake(CGRectGetWidth(_collectionView.bounds) / 2-1 , CGRectGetWidth(_collectionView.bounds)*3/4);
    
    return itemSize;


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    DailyPic *pic = _photoArr[indexPath.item];


}
-(void)sendRequest{

    //1、创建URL连接
    
    NSURL *url = [NSURL URLWithString:_urlString];
    //2、创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    //3、创建返回对象(无特殊需求置为nil)
    NSURLResponse *reqponse = nil;
    //创建错误对象
    NSError *error = nil;
    //4、创建请求数据 连接
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&reqponse error:&error];
    //3.获取数据()
    
    if (data == nil) {
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    _photoArr  = [NSMutableArray arrayWithCapacity:30];
    
       array = dict[@"data"];
    for (NSDictionary *dic in array) {
        
        DailyPic *pic = [DailyPic new];
        [pic setValuesForKeysWithDictionary:dic];
        [_photoArr addObject:pic];
    }
    
    for (DailyPic *pic in _photoArr) {
        NSLog(@"%@",pic);
    }


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
