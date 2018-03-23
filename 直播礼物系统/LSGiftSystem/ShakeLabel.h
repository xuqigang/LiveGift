//
//  ShakeLabel.h
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeLabel : UILabel
// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;
// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;
@end
