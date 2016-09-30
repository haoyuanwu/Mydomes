//
//  _23AppDelegate.m
//  音频Demo
//
//  Created by ibokan on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 IOS播放音频使用AVAudioPlayer类,必须加入AVFoundation.framework
 并且需要在使用的类中加入头文件:#import<AVFoundation/AVFoundation.h>
 本Demo有3个类要包含头文件，为了方便，在预编译文件”音频Demo-Prefix.pch“中引入该头文件
 */  

#import "_23AppDelegate.h"
#import "AVAudioPlayerVC.h"
#import "NetAVAudioPlayerVC.h"
@implementation _23AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    AVAudioPlayerVC * audioVC = [[AVAudioPlayerVC alloc] init];//本地播放音频文件
    NetAVAudioPlayerVC * netAudioVC = [[NetAVAudioPlayerVC alloc] init];//网络获取音频
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:netAudioVC];
    [netAudioVC release];
    UITabBarController * tabbarC  = [[UITabBarController alloc] init];
    tabbarC.viewControllers = [[[NSArray alloc] initWithObjects:audioVC,naVC, nil] autorelease];
    audioVC.tabBarItem.title = @"本地音频";
    naVC.tabBarItem.title = @"网络音频";
    [audioVC release];
    [naVC release];
    self.window.rootViewController = tabbarC;
    [tabbarC release];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
