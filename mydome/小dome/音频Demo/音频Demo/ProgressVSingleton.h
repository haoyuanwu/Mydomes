//
//  ProgressVSingleton.h
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 //单例
 */

#import <Foundation/Foundation.h>

@interface ProgressVSingleton : NSObject
@property(nonatomic,retain)AVAudioPlayer * player;
@property(nonatomic,retain)UILabel * progressLabel;
@property(nonatomic,retain)UILabel * timeLabel;

+(id)defaultSingleton;
@end
