//
//  PanProgressViewWithSingleton.h
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
//利用单例传值的封装进度条
*/

#import <Foundation/Foundation.h>

@interface PanProgressViewWithSingleton : UIProgressView
{
    CGPoint lastPoint;
    UIView * _clearView;
}

-(id)initWithFrame:(CGRect)frame ProgressViewStyle:(UIProgressViewStyle)style;
@end
