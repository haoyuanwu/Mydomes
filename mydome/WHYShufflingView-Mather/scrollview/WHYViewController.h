//
//  ViewController.h
//  scrollview
//
//  Created by 吴昊原 on 15/7/14.
//  Copyright (c) 2015年 wuhaoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol WHYscollViewdelegate <NSObject>

-(void)TouchAction:(NSInteger)index;

@end


@interface WHYViewController : UIViewController
//@property(nonatomic,strong)UIScrollView *imgscrollview;
//@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSArray *urlarray;
@property(nonatomic,assign)CGFloat timerCount;

@property(nonatomic,strong)id<WHYscollViewdelegate>delegate;


@end

