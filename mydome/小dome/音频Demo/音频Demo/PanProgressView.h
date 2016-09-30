//
//  PanProgressView.h
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 利用属性传值的封装进度条
 */


#import <UIKit/UIKit.h>
@interface PanProgressView : UIProgressView
{
    CGPoint lastPoint;
    UIView * _clearView;
}
@property(nonatomic,retain)AVAudioPlayer * player;
@property(nonatomic,retain)UILabel * progressLabel;
@property(nonatomic,retain)UILabel * timeLabel;

-(id)initWithFrame:(CGRect)frame ProgressViewStyle:(UIProgressViewStyle)style;
@end
