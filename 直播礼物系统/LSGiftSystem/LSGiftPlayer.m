//
//  LSGiftPlayer.m
//  GIF播放动画
//
//  Created by Xuqigang on 2017/6/16.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import "LSGiftPlayer.h"


#import "LSGiftPlayer.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface LSGiftPlayer()
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation LSGiftPlayer


- (instancetype) initInView:(UIView *) view
{
    self = [super init];
    if (self) {
        

        self.bigGiftDataSource = [NSMutableArray arrayWithCapacity:1];
        
        self.gifContentView = [[UIView alloc] initWithFrame:view.bounds];
        self.gifContentView.userInteractionEnabled = YES;
        
        self.gifContentView.center = view.center;
        [view insertSubview:self.gifContentView atIndex:0];
        self.isPlay = NO;
    }
    return self;
}

- (void)addGifWithName:(NSString *)gifName{
    
    
    [self.bigGiftDataSource addObject:gifName];
   
    [self play];
   
    
}
- (void) play{
    
    //如果当前没有正在播放的动画
    if (self.isPlay == NO && self.bigGiftDataSource.count > 0) {
        
        //修改动画播放状态
        self.isPlay = YES;
        self.gifContentView.alpha = 1;
        
        NSString * gifName = self.bigGiftDataSource[0];
        [self createGif:gifName];
    }
    
    
}
- (void)createGif:(NSString *)name{
    
    //    _gifContentView.layer.borderColor = UIColorFromRGB(No_Choose_Color).CGColor;
    //    _gifContentView.layer.borderWidth = 1.0;
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
    
    //礼物不存在
    if (gif == nil) {
        self.isPlay = NO;
        [self.bigGiftDataSource removeObjectAtIndex:0];
        return;
    }
    
    _gif = CGImageSourceCreateWithData((CFDataRef)gif, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.09 target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [_timer fire];
}
-(void)startLoading
{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.gifContentView.layer.contents = (__bridge id)ref;
    CFRelease(ref);
    
    if (_index == _count -  1) {
        [_timer invalidate];
        [UIView animateWithDuration:1 animations:^{
            
            self.gifContentView.alpha = 0;
           
        } completion:^(BOOL finished) {
            
            self.isPlay = NO;
            [self.bigGiftDataSource removeObjectAtIndex:0];
            if (self.bigGiftDataSource.count > 0) {
                
                [self play];
            }
            
        }];
        
    }
}
- (void)dealloc{
    if (_gif) {
        CFRelease(_gif);
    }
    NSLog(@"gif已经释放");
}
@end

