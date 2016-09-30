//
//  ViewController.m
//  scrollview
//
//  Created by 吴昊原 on 15/7/14.
//  Copyright (c) 2015年 wuhaoyuan. All rights reserved.
//

#import "WHYViewController.h"

#define widths   [UIScreen mainScreen].bounds.size.width
#define heights  [UIScreen mainScreen].bounds.size.height
@interface WHYViewController ()<UIScrollViewDelegate>
{
    BOOL mybool;
    CGFloat X;
    UIPageControl *page;
}
@property(nonatomic,strong)UIScrollView *imgscrollview;
@property(nonatomic,strong)NSTimer *timer;

@end
static NSInteger tags = 100;
@implementation WHYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _urlarray = [[NSArray alloc]initWithObjects:@"0.png",@"2.png",@"4.png",@"5.png",@"3.jpg", nil];
    _imgscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, widths, heights)];
    _imgscrollview.contentSize = CGSizeMake(widths * (_urlarray.count + 2), heights);
    _imgscrollview.delegate = self;
    _imgscrollview.pagingEnabled = YES;
    _imgscrollview.showsHorizontalScrollIndicator = NO;
    X = widths;
    UIImageView *imgst = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widths, heights)];
//    imgst.image = [UIImage imageNamed:_urlarray[_urlarray.count-1]];
    [imgst sd_setImageWithURL:[NSURL URLWithString:_urlarray[_urlarray.count-1]] placeholderImage:nil];
    
   [_imgscrollview addSubview:imgst];
    for (int i = 0; i < _urlarray.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(widths * (i+1), 0, widths, heights)];
        img.image = [UIImage imageNamed:_urlarray[i]];
        [img sd_setImageWithURL:[NSURL URLWithString:_urlarray[i]] placeholderImage:[UIImage imageNamed:@""]];
        img.userInteractionEnabled = YES;
        img.tag = tags;
        tags++;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [img addGestureRecognizer:tap];
        [_imgscrollview addSubview:img];
    }
    
    UIImageView *imgla = [[UIImageView alloc]initWithFrame:CGRectMake(widths * (_urlarray.count + 1),0, widths, heights)];
    [imgla sd_setImageWithURL:[NSURL URLWithString:_urlarray[0]] placeholderImage:nil];
//    imgla.image = [UIImage imageNamed:_urlarray[0]];
    [_imgscrollview addSubview:imgla];
    _imgscrollview.contentOffset = CGPointMake(widths, heights);
    [self.view addSubview:_imgscrollview];
    
    _timer =  [NSTimer scheduledTimerWithTimeInterval:_timerCount target:self selector:@selector(sliding) userInfo:nil repeats:YES];

    page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, heights - 30, widths, 30)];
    page.numberOfPages = _urlarray.count;
    page.pageIndicatorTintColor = [UIColor grayColor];
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:page];
    
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    [self.delegate TouchAction:sender.view.tag-100];
   
}
-(void)sliding{
    
    X += widths;
    [UIView animateWithDuration:0.25 animations:^{
        mybool = YES;
        _imgscrollview.contentOffset = CGPointMake(X, heights);
        if (X == _imgscrollview.contentSize.width - widths) {
            page.currentPage = 0;
        }
    }];
    if (X == _imgscrollview.contentSize.width - widths) {
        _imgscrollview.contentOffset = CGPointMake(widths, heights);
        X = widths;
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    mybool = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    page.currentPage = (scrollView.contentOffset.x / widths) - 1;
    CGRect rect = _imgscrollview.frame;
    rect.origin.y = 0;
    _imgscrollview.frame = rect;
    if (mybool == NO) {
        if (scrollView.contentOffset.x == scrollView.contentSize.width - widths) {
            scrollView.contentOffset = CGPointMake(widths, heights);
            X = widths;
        }else if(scrollView.contentOffset.x == 0){
            scrollView.contentOffset = CGPointMake(widths * _urlarray.count, heights);
        }
    }
    X = scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   _timer =  [NSTimer scheduledTimerWithTimeInterval:_timerCount target:self selector:@selector(sliding) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    CGRect rect = _imgscrollview.frame;
    rect.origin.y = 0;
    _imgscrollview.frame = rect;
}
@end
