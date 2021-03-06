//
//  AnimOperation.h
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PresentView.h"
#import "GiftModel.h"

@interface AnimOperation : NSOperation
@property (nonatomic,strong) PresentView *presentView;
@property (nonatomic,strong) UIView *listView;
@property (nonatomic,strong) GiftModel *model;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) NSString *userID; // 新增用户唯一标示，记录礼物信息

// 回调参数增加了结束时礼物累计数 
+ (instancetype)animOperationWithUserID:(NSString *)userID model:(GiftModel *)model finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;

@end
