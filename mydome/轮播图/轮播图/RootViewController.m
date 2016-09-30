//
//  RootViewController.m
//  轮播图
//
//  Created by lanou3g on 15/6/16.
//  Copyright (c) 2015年 王庆晗. All rights reserved.
//

#import "RootViewController.h"
#import "GuideViewController.h"
#import <HYUIkit/HYUIkit.h>
@interface RootViewController ()
{
    GuideViewController *guideVC;
    GuidePageView *guidePageV;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    guideVC = [[GuideViewController alloc]init];
    
    guidePageV = [[GuidePageView alloc] initWithFrame:self.view.bounds];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i<6; i++) {
        [arr addObject:[NSString stringWithFormat:@"v6_guide_%d.png",i]];
    }
    guidePageV.guidePageArr = arr;
    [self.view addSubview:guidePageV];
    
//    [self.view addSubview:guideVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
