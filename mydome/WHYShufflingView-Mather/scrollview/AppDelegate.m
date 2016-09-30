//
//  AppDelegate.m
//  scrollview
//
//  Created by 吴昊原 on 15/7/14.
//  Copyright (c) 2015年 wuhaoyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "WHYViewController.h"
@interface AppDelegate ()<WHYscollViewdelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    WHYViewController *VC = [[WHYViewController alloc]init];
    NSArray *array = [[NSArray alloc]initWithObjects:@"http://ww4.sinaimg.cn/mw690/e4d6f8c4jw1et9xdwh5m3j20dc0hsmz4.jpg",@"http://ww3.sinaimg.cn/mw690/e4d6f8c4jw1et9xdxj9foj20dc0hs3zz.jpg",@"http://ww2.sinaimg.cn/mw690/e4d6f8c4jw1esot5r68erj20hs0dc0us.jpg",@"http://ww4.sinaimg.cn/mw690/e4d6f8c4jw1esm4qdoc08j20js0qojx3.jpg", nil];
    VC.delegate = self;
    VC.urlarray = array;
    VC.timerCount = 1.0;
    
    self.window.rootViewController = VC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}
//点击图片触法方法
-(void)TouchAction:(NSInteger)index{
    NSLog(@"%ld",index);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
