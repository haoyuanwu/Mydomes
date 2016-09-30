//
//  LoadingAndDocPlayerVC.m
//  音频Demo
//
//  Created by ibokan on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadingAndDocPlayerVC.h"

@implementation LoadingAndDocPlayerVC
@synthesize response = _response;
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
-(void)yibuLoad{
    NSString * urlString = @"http://cwlserver.cxql.net/attach/message/201511/20151116092425757_record_cwl.caf";
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    //状态栏加载菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)doPlay{
    [player play];
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
    [_response release],_response = nil;
    [player release],player = nil;
    [receiveData release],receiveData = nil;
    [super dealloc];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44)];
    aView.backgroundColor = [UIColor orangeColor];
    self.view = aView;
    [aView release];
    
    self.navigationItem.title = @"下载到本地播放";
    
    
    //初始化button
    //异步播放歌曲，边缓冲边播放,异步连接
    [self buildButtonWithFrame:CGRectMake(100, 50, 120, 40) Title:@"load" Action:@selector(yibuLoad)];
    [self buildButtonWithFrame:CGRectMake(100, 100, 120, 40) Title:@"play" Action:@selector(doPlay)];
    [self buildButtonWithFrame:CGRectMake(100, 150, 120, 40) Title:@"pause" Action:@selector(doPause)];
    [self buildButtonWithFrame:CGRectMake(100, 200, 120, 40) Title:@"stop" Action:@selector(doStop)];
    
    UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 240, 120, 40)];
    aLabel.text = @"下载进度条";
    aLabel.textAlignment = UITextAlignmentCenter;
    aLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aLabel];
    //建立缓冲进度条
    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame = CGRectMake(10, 290, 300, 20);
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
#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    receiveData = [[NSMutableData alloc] init];
    allLength = [response expectedContentLength];
    
    self.response = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receiveData appendData:data];
    
    //改变进度条值
    progress.progress = [receiveData length]/allLength;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
   
    //关闭状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    /*
    将下载好的数据写入沙盒的Documents下
    */
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//沙盒的Documents路径
	NSLog(@"+++++docPath = %@",docPath);
    NSString *filePath=[docPath  stringByAppendingPathComponent:[self.response  suggestedFilename]];
    NSLog(@"+++++filePath = %@",filePath);
    
    [receiveData writeToFile:filePath atomically:YES];
    
    
    //以该路径初始化一个url,然后以url初始化player
    NSError * error;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    [player prepareToPlay];
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //网络连接失败，关闭菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
}
@end
