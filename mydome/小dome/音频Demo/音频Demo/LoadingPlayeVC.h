//
//  LoadingPlayeVC.h
//  音频Demo
//
//  Created by ibokan on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 边下载边播放Demo,音频数据存在缓存
 */

#import <UIKit/UIKit.h>

@interface LoadingPlayeVC : UIViewController<NSURLConnectionDataDelegate>
{
    NSMutableData * receiveData;
    AVAudioPlayer * player;
    UIProgressView * progress;
    CGFloat allLength;
}
@end
