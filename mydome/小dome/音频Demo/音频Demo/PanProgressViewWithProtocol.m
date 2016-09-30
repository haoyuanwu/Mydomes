//
//  PanProgressViewWithProtocol.m
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PanProgressViewWithProtocol.h"

@implementation PanProgressViewWithProtocol
@synthesize delegate = _delegate;

-(id)initWithFrame:(CGRect)frame ProgressViewStyle:(UIProgressViewStyle)style{
    if (self = [super initWithFrame:frame]) {
        
        self.progressViewStyle = style;
        _clearView =[[UIView alloc] initWithFrame:CGRectMake(0, - (frame.size.height -10)*0.5f, frame.size.width, frame.size.height)];
        _clearView.backgroundColor = [UIColor redColor];
        _clearView.alpha = 0.4;
        [self addSubview:_clearView];
    }
    return self;
    
}
-(void)dealloc{
    [_clearView release],_clearView = nil;
    [super dealloc];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    AVAudioPlayer * player = [self.delegate theAVAudioPlayer];
    UILabel * labelOftime = [self.delegate theTimeLabel];
    UILabel * labelOfprogress = [self.delegate theProgressLabel];
    
    lastPoint = [[touches anyObject] locationInView:_clearView];
    CGFloat widthWithtouchView = _clearView.frame.size.width;    
    player.currentTime = player.duration * (lastPoint.x /widthWithtouchView);
    self.progress = lastPoint.x /widthWithtouchView;
    
    labelOfprogress.text = [NSString stringWithFormat:@"进度: %d%%",(int)(self.progress*100)];//修改进度label内容
    labelOftime.text = [NSString stringWithFormat:@"%3d/%3d秒",
                           (int)(player.currentTime),(int)(player.duration)];//修改时间label内容
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    AVAudioPlayer * player = [self.delegate theAVAudioPlayer];
    UILabel * labelOftime = [self.delegate theTimeLabel];
    UILabel * labelOfprogress = [self.delegate theProgressLabel];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:_clearView];
    CGFloat widthWithtouchView = _clearView.frame.size.width;
    CGFloat precent = currentPoint.x /widthWithtouchView;
    self.progress =precent;
    player.currentTime = player.duration * precent;
    
    labelOfprogress.text = [NSString stringWithFormat:@"进度: %d%%",(int)(self.progress*100)];//修改进度label内容
    labelOftime.text = [NSString stringWithFormat:@"%3d/%3d秒",
                        (int)(player.currentTime),(int)(player.duration)];//修改时间label内容

}

@end
