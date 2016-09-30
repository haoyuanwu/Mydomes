//
//  ProgressVSingleton.m
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*
 1、单例格式
 2、单例内存管理
 */
#import "ProgressVSingleton.h"

@implementation ProgressVSingleton
@synthesize player = _player,progressLabel = _progressLabel,timeLabel = _timeLabel;

+(id)defaultSingleton{
    static ProgressVSingleton * singleton = nil;
    if (singleton == nil) {
        singleton = [[ProgressVSingleton alloc] init] ;
    }
    return singleton;
}
-(void)dealloc{
    self.player = nil;
    [super dealloc];
}
@end
