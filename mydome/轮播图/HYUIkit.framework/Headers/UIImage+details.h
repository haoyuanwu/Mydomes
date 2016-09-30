//
//  UIImage+alpha.h
//  Component
//
//  Created by Chance on 15/7/14.
//  Copyright (c) 2015年 济南掌游. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (details)

/**
 *  改变UIImage颜色（必须为纯色）
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

/**
 *  改变image的方向（拍照之后）
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end
