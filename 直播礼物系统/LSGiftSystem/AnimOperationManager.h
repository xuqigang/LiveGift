//
//  AnimOperationManager.h
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@interface AnimOperationManager : NSObject
+ (instancetype)sharedManager;
@property (nonatomic,strong) UIView *parentView;
@property (nonatomic,strong) GiftModel *model;
/// 动画操作 : 需要UserID和回调
- (void)animWithUserID:(NSString *)userID model:(GiftModel *)model finishedBlock:(void(^)(BOOL result))finishedBlock;

/// 取消上一次的动画操作
- (void)cancelOperationWithLastUserID:(NSString *)userID;
@end
