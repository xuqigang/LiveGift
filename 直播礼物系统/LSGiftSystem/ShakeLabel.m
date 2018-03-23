//
//  ShakeLabel.m
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import "ShakeLabel.h"

@implementation ShakeLabel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        for(NSString *fontfamilyname in [UIFont familyNames])
//        {
//            NSLog(@"family:'%@'",fontfamilyname);
//            for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//            {
//                NSLog(@"\tfont:'%@'",fontName);
//            }
//            NSLog(@"-------------");
//        }
        /*
         Copperplate
         Copperplate-Light
         Copperplate
         Copperplate-Bold
         */
        
    }
    return self;
}
- (void)startAnimWithDuration:(NSTimeInterval)duration {
    
//    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/3.0 animations:^{
//            
//            self.transform = CGAffineTransformMakeScale(3, 3);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
//            
//            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{
//            
//            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        }];
//    } completion:nil];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(4, 4);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:nil];
        }];
}

//  重写 drawTextInRect 文字描边效果
- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 5);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end
