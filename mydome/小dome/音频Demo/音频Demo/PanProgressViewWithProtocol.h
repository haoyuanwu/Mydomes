//
//  PanProgressViewWithProtocol.h
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 //利用协议传值的封装进度条
 1、协议原理
 2、协议格式
 3、内部调用
 */

#import <UIKit/UIKit.h>


@protocol PanProgressViewDelegate <NSObject>

-(AVAudioPlayer *)theAVAudioPlayer;
-(UILabel *)theProgressLabel;
-(UILabel *)theTimeLabel;
@end

@interface PanProgressViewWithProtocol : UIProgressView
{
    CGPoint lastPoint;
    UIView * _clearView;
}
@property(nonatomic,assign)id<PanProgressViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame ProgressViewStyle:(UIProgressViewStyle)style;

@end





