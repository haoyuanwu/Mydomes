//
//  GetLabelViewController.h
//  SendPingLun
//
//  Created by mei on 14-8-6.
//  Copyright (c) 2014年 mei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#import "MLEmojiLabel.h"
@interface GetLabelViewController : UIViewController<MLEmojiLabelDelegate>

/*
    MLEmojiLabel相关
 */
@property(nonatomic,strong)MLEmojiLabel *emojiLabel;

@property (nonatomic, strong) UIImageView *textBackImageView;

@property(nonatomic,strong) NSString *contents;


@end
