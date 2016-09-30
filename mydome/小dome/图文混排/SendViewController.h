//
//  SendViewController.h
//  SendPingLun
//
//  Created by mei on 14-8-6.
//  Copyright (c) 2014年 mei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#import "ZBMessageInputView.h"
#import "ZBMessageManagerFaceView.h"
#import "ZBMessageViewState.h"
#import "BWMsgInputView.h"

#import "GetLabelViewController.h"



@interface SendViewController : UIViewController

- (IBAction)sendFace:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtContent;
- (IBAction)sendContent:(id)sender;


//发送表情相关
@property (nonatomic,strong) BWMsgInputView *messageToolView;

@property (nonatomic,strong) ZBMessageManagerFaceView *faceView;

@property (nonatomic,assign) CGFloat previousTextViewContentHeight;

- (void)messageViewAnimationWithMessageRect:(CGRect)rect  withMessageInputViewRect:(CGRect)inputViewRect andDuration:(double)duration andState:(ZBMessageViewState)state;





@end
