//
//  LoadingAndDocPlayerVC.h
//  音频Demo
//
//  Created by ibokan on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 下载到本地播放，将网络获取的音频写文件到本地
 */
@interface LoadingAndDocPlayerVC : UIViewController<NSURLConnectionDataDelegate>
{
    UIProgressView * progress;
    CGFloat allLength;
    
    AVAudioPlayer * player;
    NSMutableData * receiveData;

}
@property(nonatomic,retain)NSURLResponse * response;//用来获取下载的文件的文件名

@end
