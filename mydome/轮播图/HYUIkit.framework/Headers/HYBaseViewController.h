//
//  HYBaseViewController.h
//  HYUIkit
//
//  Created by iPhone on 15/10/27.
//  Copyright © 2015年 wuhaoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseViewController : UIViewController

/**
 *  获取系统时间类
 */
+ (NSDateComponents *)getTimer;

/**
 *  自适应高度方法
 */
- (CGFloat)textHeight:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;

@end
