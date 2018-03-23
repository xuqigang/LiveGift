//
//  LSGiftPlayer.h
//  GIF播放动画
//
//  Created by Xuqigang on 2017/6/16.
//  Copyright © 2017年 徐其岗. All rights reserved.
//
//大礼物播放
#import <UIKit/UIKit.h>

@interface LSGiftPlayer : NSObject
@property (nonatomic, strong) NSMutableArray * bigGiftDataSource;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, assign) BOOL isPlay;

- (instancetype) initInView:(UIView *) view;

- (void)addGifWithName:(NSString *)gifName;

@end
