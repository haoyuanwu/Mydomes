//
//  LoadingPlayeVC.m
//  音频Demo
//
//  Created by ibokan on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadingPlayeVC.h"

@implementation LoadingPlayeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)buildButtonWithFrame:(CGRect)frame Title:(NSString *)title Action:(SEL)selector{
    UIButton * aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    aButton.frame = frame;
    [aButton setTitle:title forState:UIControlStateNormal];
    [aButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
}
#pragma mark - button methods
//异步播放歌曲，边缓冲边播放,异步连接
-(void)yibuPlayer{
    NSString * urlString = @"http://127.0.0.1/a.mp3";
    //不能辨识汉字，需要把汉字转换成UTF8格式
    //    NSString * urlString = [@"http://127.0.0.1/没那么简单.mp3" 
    //                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",urlString);
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [url release];
    
    //异步请求数据
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlRequest release];
    //给状态栏加菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}
-(void)doPause{
    [player pause];
}
-(void)doStop{
    [player stop];
    player.currentTime = 0;
}
#pragma mark - View lifecycle

-(void)dealloc{
    [receiveData release],receiveData = nil;
    [player release],player = nil;
    [super dealloc];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44)];
    aView.backgroundColor = [UIColor orangeColor];
    self.view = aView;
    [aView release];
    
    self.navigationItem.title = @"边下载边播放";
    
    
    //初始化button
    //异步播放歌曲，边缓冲边播放,异步连接
    [self buildButtonWithFrame:CGRectMake(100, 50, 120, 40) Title:@"play" Action:@selector(yibuPlayer)];
    [self buildButtonWithFrame:CGRectMake(100, 100, 120, 40) Title:@"pause" Action:@selector(doPause)];
    [self buildButtonWithFrame:CGRectMake(100, 150, 120, 40) Title:@"stop" Action:@selector(doStop)];
    
    
    UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 120, 40)];
    aLabel.text = @"缓冲进度条";
    aLabel.textAlignment = UITextAlignmentCenter;
    aLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aLabel];
    //建立缓冲进度条
    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame = CGRectMake(10, 245, 300, 20);
    progress.progress = 0;
    [self.view addSubview:progress];
    [progress release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mak - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response++++++++++++++++++ %@",[response suggestedFilename]);
    if (receiveData) {
        [receiveData release];
    }
    receiveData = [[NSMutableData alloc] init];
    
        allLength = [response expectedContentLength];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receiveData  appendData:data];
    
    if ([receiveData length] > 20000) {
        
        if (player == nil) {
            
            player = [[AVAudioPlayer alloc] initWithData:receiveData error:nil];
            [player prepareToPlay];            
            
        }else if (player.isPlaying == NO){
            
            [player play];
            
        }
        
    }
    
    
    
    
    //改变进度条进度
    progress.progress = [receiveData length]/allLength;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"_____________finishloading");
    
    //缓冲完成后关闭菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

@end
