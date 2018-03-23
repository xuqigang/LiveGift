//
//  PresentView.m
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import "PresentView.h"
@interface PresentView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加
@end

@implementation PresentView

// 根据礼物个数播放动画
- (void)animateWithCompleteBlock:(completeBlock)completed{

    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self shakeNumberLabel];
    }];
    self.completeBlock = completed;
}

- (void)shakeNumberLabel{
    _animCount ++;
//    NSLog(@"shakeNumberLabel");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidePresendView) object:nil];//可以取消成功。
    [self performSelector:@selector(hidePresendView) withObject:nil afterDelay:2];

    self.skLabel.text = [NSString stringWithFormat:@"x %ld",_animCount];
    
    //执行连发数量动画
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.skLabel.transform = CGAffineTransformMakeScale(4, 4);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.skLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.skLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];

    
//    [self.skLabel startAnimWithDuration:0.3];
}

- (void)hidePresendView
{
    [UIView animateWithDuration:0.30 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.completeBlock) {
            self.completeBlock(finished,_animCount);
        }
        [self reset];
        _finished = finished;
//        NSLog(@"%ld",_animCount);
        [self removeFromSuperview];
    }];
}

// 重置
- (void)reset {
    
    self.frame = _originFrame;
    self.alpha = 1;
    self.animCount = 0;
    self.skLabel.text = @"";
}

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _originFrame = self.frame;
        [self setUI];
    }
    return self;
}

#pragma mark 布局 UI
- (void)layoutSubviews {
    
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    _headImageView.layer.borderWidth = 1;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height / 2;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * headImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageViewTap:)];
    [_headImageView addGestureRecognizer:headImageTap];
    
    _giftImageView.frame = CGRectMake(self.frame.size.width - 35, self.frame.size.height - UIScale(60), UIScale(65), UIScale(55));
    CGPoint giftPoint = _giftImageView.center;
    giftPoint.y = _headImageView.center.y;
    _giftImageView.center = giftPoint;
    
    _nameLabel.frame = CGRectMake(_headImageView.frame.size.width + 5, 10, _headImageView.frame.size.width * 3 + 50, 16);
    _giftLabel.frame = CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_headImageView.frame) - 10 - 10, _nameLabel.frame.size.width, 16);
    
    _bgImageView.frame = self.bounds;
    _bgImageView.layer.cornerRadius = self.frame.size.height / 2;
    _bgImageView.layer.masksToBounds = YES;
    
    _skLabel.frame = CGRectMake(CGRectGetMaxX(self.giftImageView.frame) + 5,0, 100, self.frame.size.height);
    
}

#pragma mark 初始化 UI
- (void)setUI {
    
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.backgroundColor = [UIColor grayColor];
//    _bgImageView.alpha = 0.3;
    _headImageView = [[UIImageView alloc] init];
    _giftImageView = [[UIImageView alloc] init];
    _nameLabel = [[UILabel alloc] init];
    _giftLabel = [[UILabel alloc] init];
    _nameLabel.textColor  = [UIColor whiteColor];
    _nameLabel.font = FONT(14);
    _giftLabel.textColor  = UIColorFromRGB(0xead879);;
    _giftLabel.font = FONT(14);
    
    // 初始化动画label
    _skLabel =  [[ShakeLabel alloc] init];
    _skLabel.borderColor = [UIColor whiteColor];
    _skLabel.adjustsFontSizeToFitWidth = YES;

//    _skLabel =  [[UILabel alloc] init];
    _skLabel.textColor = UIColorFromRGB(0xeb413e);
    _skLabel.font = [UIFont fontWithName:@"HYYanKaiF" size:UIScale(35)];
//   HYYanKaiF
//邯郸-韩绍杰邯郸体

    
    _skLabel.textAlignment = NSTextAlignmentLeft;
    _animCount = 0;
    
    [self addSubview:_bgImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_giftLabel];
    [self addSubview:_skLabel];
    [self addSubview:_headImageView];
    [self addSubview:_giftImageView];
}

//头像点击
- (void) headImageViewTap:(UIGestureRecognizer *) ges
{
    
}

- (void)setModel:(GiftModel *)model {
    _model = model;
    NSURL * url = [NSURL URLWithString:model.headImage];
    _headImageView.image = [UIImage imageNamed:@"person.png"];
    _giftImageView.image = [UIImage imageNamed:model.giftImage];
    _nameLabel.text = model.name;
    _giftLabel.text = [NSString stringWithFormat:@"送了一个 %@",model.giftName];
    _giftCount = model.giftCount;
}


@end
