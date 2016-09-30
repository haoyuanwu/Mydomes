//
//  AVAudioPlayerVC.m
//  音频Demo
//
//  Created by ibokan on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AVAudioPlayerVC.h"
#import "PanProgressView.h"
#import "PanProgressViewWithSingleton.h"
#import "ProgressVSingleton.h"
@implementation AVAudioPlayerVC

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
-(void)buildButtonWithFrame:(CGRect)frame Title:(NSString *)title Action:(SEL)action {
    UIButton *translateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    translateButton.frame = frame;
    [translateButton setTitle:title forState:UIControlStateNormal];
    [translateButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:translateButton];
}
-(UILabel *)buildLabelWithFrame:(CGRect)frame Title:(NSString *)title{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.backgroundColor = [UIColor clearColor]; 
    label.numberOfLines = 0;
    [self.view addSubview:label]; 
    return [label autorelease];
}
#pragma mark - AVAudioPlayer methods

-(void)doPlay{
    [player play];
}
-(void)doPause{
    [player pause];
}

-(void)doStop{
    [player stop];
    //调用上面方法后必须加下面一句，不然和[autioplayer pause]是一样的效果
    player.currentTime = 0;
}
#pragma mark - 手势

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    lastPoint = [[touches anyObject] locationInView:self.view];
    NSLog(@"laP = %@",NSStringFromCGPoint(lastPoint));
    CGFloat widthWithtouchView = cleanview.frame.size.width;    
    player.currentTime = player.duration * (lastPoint.x /widthWithtouchView);
    progressV.progress = lastPoint.x /widthWithtouchView;
    
    labelOfprogress.text = [NSString stringWithFormat:@"进度: %d%%",(int)(progressV.progress*100)];//修改进度label内容
    labelOftime.text = [NSString stringWithFormat:@"%3d/%3d秒",
                        (int)(player.currentTime),(int)(player.duration)];//修改时间label内容

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentPoint = [[touches anyObject] locationInView:cleanview];
    CGFloat widthWithtouchView = cleanview.frame.size.width;
    CGFloat precent = currentPoint.x /widthWithtouchView;
    progressV.progress =precent;
    player.currentTime = player.duration * precent;
    
    labelOfprogress.text = [NSString stringWithFormat:@"进度: %d%%",(int)(progressV.progress*100)];//修改进度label内容
    labelOftime.text = [NSString stringWithFormat:@"%3d/%3d秒",
                        (int)(player.currentTime),(int)(player.duration)];//修改时间label内容
}
#pragma mark - View lifecycle

-(void)dealloc{
    [player release],player = nil;
    [cleanview release],cleanview = nil;
    [super dealloc];
}
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49)];
    aView.backgroundColor = [UIColor whiteColor];
    self.view = aView;
    [aView release];
    
    //    创建label
    [self buildLabelWithFrame:CGRectMake(0, 0, 320, 100) Title:@"播放本地音乐，拖动进度条可以改变歌曲进度"];
    labelOfprogress = [self buildLabelWithFrame:CGRectMake(30, 150, 100, 50) Title:@"进度: 0%"];
    labelOfvolume = [self buildLabelWithFrame:CGRectMake(30, 220, 100, 50) Title:@"音量:50%"];
    
    //    创建进度条
    progressV = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressV.frame = CGRectMake(116, 170, 165, 50);
    [aView addSubview:progressV];
    [progressV release];
    //在进度条贴一个透明的view
    cleanview =[[UIView alloc] initWithFrame:CGRectMake(116, 160, 165, 30)];
    cleanview.backgroundColor = [UIColor redColor];
    cleanview.alpha = 0.4;
    [self.view addSubview:cleanview];
    [cleanview release];
   
    //    创建slider
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(116, 222, 165, 50)];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    slider.value = 0.5;
    [slider addTarget:self action:@selector(changeVolume:) forControlEvents:UIControlEventValueChanged];
    [aView addSubview:slider];
    [slider release];
    
    //    创建button
    [self buildButtonWithFrame:CGRectMake(160-40-90, 350, 80, 40) Title:@"播放" Action:@selector(doPlay)];    
    [self buildButtonWithFrame:CGRectMake(160-40, 350, 80, 40) Title:@"暂停" Action:@selector(doPause)];
    [self buildButtonWithFrame:CGRectMake(160+40+10, 350, 80, 40) Title:@"停止" Action:@selector(doStop)];
    
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"没那么简单" ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
    labelOftime = [self buildLabelWithFrame:CGRectMake(progressV.center.x-50, progressV.center.y-5, 100, 40) 
                                      Title:[[NSString alloc] initWithFormat:@"  0/%3d秒",(int)(player.duration)]];

    /*
     //利用属性传值的封装进度条
    PanProgressView * progress = [[PanProgressView alloc] initWithFrame:CGRectMake(15, 220, 200, 30) ProgressViewStyle:UIProgressViewStyleBar];
    progress.player = player;
    progress.progressLabel = labelOfprogress;
    progress.timeLabel = labelOftime;
    [self.view addSubview:progress];
    [progress release];
     */
   
    /*
     //利用协议传值的封装进度条
     PanProgressViewWithProtocol * progress = [[PanProgressViewWithProtocol alloc] initWithFrame:CGRectMake(15, 220, 200, 30) ProgressViewStyle:UIProgressViewStyleBar];
     progress.delegate = self;
     [self.view addSubview:progress];
     [progress release];
     */
    
    
     //利用单例传值的封装进度条
     PanProgressViewWithSingleton * progress = [[PanProgressViewWithSingleton alloc] initWithFrame:CGRectMake(15, 220, 200, 30) ProgressViewStyle:UIProgressViewStyleBar];
     ProgressVSingleton * singleton = [ProgressVSingleton defaultSingleton];
     singleton.player = player;
     singleton.progressLabel = labelOfprogress;
     singleton.timeLabel = labelOftime;
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
#pragma mark - PanProgressViewDelegate

-(AVAudioPlayer *)theAVAudioPlayer{
    
    return player;
}

-(UILabel *)theTimeLabel{
    
    return labelOftime;
}

-(UILabel *)theProgressLabel{
    
    return labelOfprogress;
}

#pragma mark - method of change label text 
//歌曲进度显示
-(void)changeProgress{
    float pecent = player.currentTime/player.duration;
    progressV.progress = pecent;//修改进度条进度
//    int pecent = (int)(player.currentTime/player.duration*100);
    labelOfprogress.text = [NSString stringWithFormat:@"进度: %d%%",(int)(pecent*100)];//修改进度label内容
    labelOftime.text = [NSString stringWithFormat:@"%3d/%3d秒",
                        (int)(player.currentTime),(int)(player.duration)];//修改时间label内容
}
//歌曲音量显示
-(void)changeVolume:(UISlider *)sender{
    NSLog(@"sfsadf");
    player.volume = sender.value;
    labelOfvolume.text = [NSString stringWithFormat:@"音量: %d%%",(int)(sender.value*100)];//修改音量label内容
}

@end
