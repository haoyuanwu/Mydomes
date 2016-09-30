//
//  NSString_Code.h
//  HYUIkit
//
//  Created by iPhone on 15/11/17.
//  Copyright © 2015年 wuhaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString_Code : NSString

/**
 *  判断是不是手机号
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel;

/**
 *  自定义正则表达式判断
 *
 *  @param regex 正则表达式
 */
- (BOOL)isJudge:(NSString *)regex;

/**
 *  验证身份证格式
 */
- (BOOL)isUserIDCard;

/**
 *  验证纯数字
 */
- (BOOL)isNumber;

/**
 *  验证数字和字母
 */
- (BOOL)isASIICode;

/**
 *  验证邮箱格式
 */
- (BOOL)isEmailCode;

/**
 *  判断是不是空
 */
- (NSString *)isExist;

/**
 *  自适应高度
 *
 *  @param width 宽度
 *  @param font  字体大戏
 *
 *  @return
 */
- (CGFloat)textHeight:(CGFloat)width font:(UIFont *)font;

@end

