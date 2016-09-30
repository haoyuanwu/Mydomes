//
//  NetAVAudioPlayerVC.h
//  音频Demo
//
//  Created by ibokan on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



/*
 音乐播放不支持网络直接播放，同步连接播放不行，所以得下载到本地播放，即靠缓存，用NSURLConnection的代理方法
 
 建立本地服务器：将音频文件拷入   硬盘/资源库/WebServer/Documents下
               打开偏好设置 -> 共享 -> 将Web共享打勾
 在浏览器输入http://127.0.0.1，页面显示 It Works!，表示本地服务器建立成功。
 在浏览器输入http://127.0.0.1/a.mp3,页面会显示该音频文件。
 */


#import <UIKit/UIKit.h>

@interface NetAVAudioPlayerVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArray;
}

@end
