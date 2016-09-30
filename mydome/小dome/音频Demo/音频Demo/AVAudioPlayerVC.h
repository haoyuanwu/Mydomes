//
//  AVAudioPlayerVC.h
//  音频Demo
//
//  Created by ibokan on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 播放本地音频
 */
#import <UIKit/UIKit.h>
#import "PanProgressViewWithProtocol.h"
@interface AVAudioPlayerVC : UIViewController<PanProgressViewDelegate>
{
    UIProgressView * progressV;
    AVAudioPlayer * player;
    UIView * cleanview;
    UILabel * labelOftime;
    UILabel * labelOfprogress;
    UILabel * labelOfvolume;
    
    CGPoint lastPoint;
}
@end
