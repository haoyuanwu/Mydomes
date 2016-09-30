//
//  PanProgressView.m
//  音频Demo
//
//  Created by ibokan on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PanProgressView.h"

@implementation PanProgressView
@synthesize player = _player,progressLabel = _progressLabel,timeLabel = _timeLabel;
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
    self.player = nil;
    self.progressLabel = nil;
    self.timeLabel = nil;
    [_clearView release],_clearView = nil;
    [super dealloc];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    lastPoint = [[touches anyObject] locationInView:_clearView];
    CGFloat widthWithtouchView = _clearView.frame.size.width;    
    self.player.currentTime = self.player.duration * (lastPoint.x /widthWithtouchView);
    self.progress = lastPoint.x /widthWithtouchView;
    
    self.progressLabel.text = [NSString stringWithFormat:@"进度: %d%%",(int)(self.progress*100)];//修改进度label内容
    self.timeLabel.text = [NSString stringWithFormat:@"%3d/%3d秒",
                        (int)(self.player.currentTime),(int)(self.player.duration)];//修改时间label内容

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint currentPoint = [[touches anyObject] locationInView:_clearView];
    CGFloat widthWithtouchView = _clearView.frame.size.width;
    CGFloat precent = currentPoint.x /widthWithtouchView;
    self.progress =precent;
    self.player.currentTime = self.player.duration * precent;
    
    self.progressLabel.text = [NSString stringWithFormat:@"进度: %d%%",(int)(self.progress*100)];//修改进度label内容
    self.timeLabel.text = [NSString stringWithFormat:@"%3d/%3d秒",
                             (int)(self.player.currentTime),(int)(self.player.duration)];//修改时间label内容
}

@end
