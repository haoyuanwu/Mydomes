//
//  ViewController.m
//  Text  UISearchBar
//
//  Created by lanou03 on 15/6/10.
//  Copyright (c) 2015年 lanou03. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
@interface ViewController ()

@property (nonatomic,retain) UISearchBar* searchBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(30,40, 220,41)];
    _searchBar.layer.cornerRadius = 4;
    _searchBar.layer.masksToBounds =YES;
    _searchBar.placeholder = @"一个大傻逼";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    _searchBar.barTintColor = [UIColor cyanColor];
    _searchBar.layer.backgroundColor = [UIColor cyanColor].CGColor;
    _searchBar.showsSearchResultsButton = NO;
    [self.view addSubview:_searchBar];
}
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
   // _searchBar.frame =CGRectMake(30,40, 260,41);
}


-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{

    return YES;

}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   searchBar.showsCancelButton = NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    _searchBar.showsScopeBar = YES;
    _searchBar.selectedScopeButtonIndex = 3;

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    NSLog(@"========%@",searchBar.text);
    
    [_searchBar resignFirstResponder];
    
    

    ;
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    
    SearchViewController *searchVC = [SearchViewController new];
    
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
@end
