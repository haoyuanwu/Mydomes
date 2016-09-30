//
//  GuideViewController.m
//  轮播图
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 王庆晗. All rights reserved.
//

#import "GuideViewController.h"

#define widths   [UIScreen mainScreen].bounds.size.width
#define heights  [UIScreen mainScreen].bounds.size.height
@interface GuideViewController ()<UIScrollViewDelegate>
{
    BOOL mybool;
    CGFloat X;
    CGFloat endX;
    CGFloat oneX;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *time;
@end


@implementation GuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self layoutScrollView];
    [self layoutPageControl];
}

//自定义布局ScrollView.
-(void)layoutScrollView{
    
    //创建UIScrollView.
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //设置scrollView的可滑动的区域大小.
    self.scrollView.contentSize = CGSizeMake(widths * 8, 0);//在这里宽度是多两张图片的位置
    //设置代理
    self.scrollView.delegate = self;
    
    //进入界面显示第二张图
    self.scrollView.contentOffset = CGPointMake(widths, 0);
    
    X = widths;//这里先给一个初始值  让即使其从第二张开始计算滑动位置
    //添加image到scrollView
    //在第一页的时候放最后一张图
    UIImageView *endimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widths, heights)];
    endimageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"v6_guide_6.png"]] ;
    [self.scrollView addSubview:endimageView];
    
    //在二页开始按顺序放图
    for (int i = 1; i <= 6; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(widths * i, 0, widths, heights)];
        NSString *imageNamed = [NSString stringWithFormat:@"v6_guide_%d.png",i];
        imageView.image = [UIImage imageNamed:imageNamed];
        
        [self.scrollView addSubview:imageView];
    }
    
    //在最后一页放第一张图
    UIImageView *OneimageView = [[UIImageView alloc]initWithFrame:CGRectMake(widths * 7, 0, widths, heights)];
    OneimageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"v6_guide_1.png"]] ;
    [self.scrollView addSubview:OneimageView];
    
    
    //设置scrollView的属性值
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:self.scrollView];
    
    endX = self.scrollView.contentSize.width - widths;//这是最后一张的位置
    oneX = self.scrollView.contentSize.width - widths * 2;//这是倒数第二张的位置
}

//自定义布局PageControl
-(void)layoutPageControl{
    //创建UIPageControl
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(85, 600, 200, 30)];
    //设置pageControl的属性值
    self.pageControl.numberOfPages = 6;
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    self.pageControl.currentPage = 0;
    //添加定时器(自动执行)
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [self.view addSubview:self.pageControl];
    
}

//定时器方法
-(void)nextImage{
    //整个方法就是无限自动滑动\
    布尔值是用来判断让不让-(void)scrollViewDidScroll:(UIScrollView *)scrollView里面的方法运行
    mybool = YES;
    
    X += widths;
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset = CGPointMake(X, 0);
        }];
    if (X == endX) {
        self.scrollView.contentOffset = CGPointMake(widths, 0);
        X = widths;
    }
}

//根据偏移量来确定圆点的位置.  这个方法会在改变scrollView.contentOffset的值的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //这里的currentPage 正常计算之后 - 1  因为是从第二张图开始计算的
    self.pageControl.currentPage = (scrollView.contentOffset.x / widths) - 1;
    if (mybool == NO) {
        if(scrollView.contentOffset.x == endX){
            //当看到最后一张的时候回到第二张
            scrollView.contentOffset = CGPointMake(widths, 0);
            self.pageControl.currentPage = 0;
            X = widths;
        }else if(scrollView.contentOffset.x == 0){
            //当看到第一张的回到倒数第二张
            scrollView.contentOffset = CGPointMake(oneX, 0);
            self.pageControl.currentPage = 7;
        }
    }
    //这句话为了在手动滑动之后 计时器进行滑动的时候保证滑动到下一张图。
    X = self.scrollView.contentOffset.x;
}


//开始拖拽停止定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始滑动的时候改变布尔值
    mybool = NO;
    [self.time invalidate];
}

//结束拖拽开启定时器
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    //添加定时器(自动执行)
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

@end
