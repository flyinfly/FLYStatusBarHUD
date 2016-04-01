//
//  FLYStatusBarHUD.m
//  FLYStatusBarHUD
//
//  Created by houzhifei on 16/3/31.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "FLYStatusBarHUD.h"

#define FLYMessageFont [UIFont systemFontOfSize:12]

/** 消息的停留时间 */
static CGFloat const FLYMessageDuration = 2.0;
/** 消息显示\隐藏的动画时间 */
static CGFloat const FLYAnimationDuration = 0.25;

static UIWindow *window_;
static NSTimer *timer_;

@implementation FLYStatusBarHUD

+ (void)showWindow {
    
    //frame
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    //显示之前先隐藏一下，避免出现问题
    window_.hidden = YES;
    window_ = [[UIWindow alloc]init];
    window_.frame = frame;
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    frame.origin.y = 0;
    [UIView animateWithDuration:FLYAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image {
    //停止定时器
    [timer_ invalidate];
    
    //显示窗口
    [self showWindow];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    button.titleLabel.font = FLYMessageFont;
    [window_ addSubview:button];
    
    [button setTitle:msg forState:UIControlStateNormal];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    
    timer_ = [NSTimer scheduledTimerWithTimeInterval:FLYMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg {
    [self showMessage:msg image:nil];
}

/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg {
    [self showMessage:msg image:[UIImage imageNamed:@"XMGStatusBarHUD.bundle/success.png"]];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg {
    [self showMessage:msg image:[UIImage imageNamed:@"XMGStatusBarHUD.bundle/error.png"]];
}

/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg {
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    //显示窗口
    [self showWindow];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = FLYMessageFont;
    label.frame = window_.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = msg;
    [window_ addSubview:label];
    
    //添加指示器
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView startAnimating];
    
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : FLYMessageFont}].width;
    CGFloat centerX = ([UIScreen mainScreen].bounds.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 * 隐藏
 */
+ (void)hide {
    [UIView animateWithDuration:FLYAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y -= frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}

@end
